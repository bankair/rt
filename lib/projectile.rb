require 'tuple'
require 'canvas'
require 'environment'

# Represent a projectile
class Projectile
  attr_accessor :position, :velocity

  def initialize(position, velocity)
    self.position = position
    self.velocity = velocity
  end

  def tick(environment)
    self.class.new(
      position + velocity,
      velocity + environment.gravity + environment.wind
    )
  end

  def self.test
    start = Tuple.point(0, 1, 0)
    velocity = Tuple.vector(1, 1.8, 0).normalize * 11.25
    p = Projectile.new(start, velocity)

    gravity = Tuple.vector(0, -0.1, 0)
    wind = Tuple.vector(-0.01, 0, 0)
    e = Environment.new(gravity, wind)
    c = Canvas.new(900, 550)

    red = Color.new(1, 0, 0)
    green = Color.new(0, 1, 0)

    begin
      loop do
        p = p.tick(e)
        x = p.position.x.round
        y = c.height - 1 - p.position.y.round
        c[x, y] = red
      end
    rescue Canvas::OutOfBoundError => e
      puts "Projectile out of image"
    end


    File.write('projectile_test.ppm', c.to_ppm)
    system('open projectile_test.ppm')
  end
end
