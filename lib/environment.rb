require 'tuple'
require 'projectile'

# Represent the environment
class Environment
  attr_accessor :gravity, :wind

  def initialize(gravity, wind)
    self.gravity = gravity
    self.wind = wind
  end
end
