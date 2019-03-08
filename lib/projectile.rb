require 'tuple'
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
    require 'environment'
    p = Projectile.new(Tuple.point(0, 1, 0), Tuple.vector(1, 1, 0).normalize)
    e = Environment.new(Tuple.vector(0, -0.1, 0), Tuple.vector(-0.1, 0, 0))
    x = p
    x = x.tick(e)
  end
end
