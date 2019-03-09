require 'color'

class Canvas
  attr_reader :width, :height

  def initialize(width, height, default_color: Color::BLACK)
    @width = width
    @height = height
    @array = Array.new(width * height, default_color)
  end

  def each_pixel(&block)
    @array.each(&block)
  end

  class OutOfBoundError < StandardError; end

  def [](x, y)
    @array[to_array_index(x, y)]
  end

  def []=(x, y, color)
    @array[to_array_index(x, y)] = color
  end

  def to_ppm
    headers = <<~PPM
      P3
      #{width} #{height}
      255
    PPM
    headers + height.times.map { |y| dump_line(y) }.join("\n") + "\n"
  end

  private

  def dump_line(y)
    result = ''
    line = ''
    width.times do |x|
      color = self[x, y]
      component = normalize_color_component(color.red, 255).to_s
      if line.size + 1 + component.size > 70
        result << line + "\n"
        line = component
      else
        line << ' ' unless line.empty?
        line << component
      end
      component = normalize_color_component(color.green, 255).to_s
      if line.size + 1 + component.size > 70
        result << line + "\n"
        line = component
      else
        line << ' ' unless line.empty?
        line << component
      end
      component = normalize_color_component(color.blue, 255).to_s
      if line.size + 1 + component.size > 70
        result << line + "\n"
        line = component
      else
        line << ' ' unless line.empty?
        line << component
      end
    end
    result + line
  end

  def normalize_color_component(value, max)
    return 0 if value < 0
    return max if value > 1
    (value * max).round
  end

  def to_array_index(x, y)
    raise OutOfBoundError unless (0...width).cover?(x) && (0...height).cover?(y)
    y.round * width + x.round
  end
end
