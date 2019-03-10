require 'canvas'
require 'transformation'

class Clock
  BLUE = Color.new(0, 0, 1)

  attr_reader :canvas

  def initialize
    @canvas = Canvas.new(500, 500)
  end

  def plot(point, color: BLUE)
    (-1..1).each do |x_offset|
      (-1..1).each do |y_offset|
        canvas[250.0 + point.x + x_offset, 250.0 + point.y + y_offset] = color
      end
    end
  end

  def draw
    p = Tuple.point(1.0, 0.0, 0.0)
    12.times { |i| plot(Transformation.rotation_z(i.to_f * Math::PI / 6.0) * p * 200.0) }
    File.write('clock_test.ppm', canvas.to_ppm)
    system('open clock_test.ppm')
  end
end

Clock.new.draw
