require 'transformation'
require 'rtmatrix'
require 'duck_enforcer'

# Base shape class
class Shape
  class Specialization < DuckEnforcer
    implement(
      :local_intersect,
      :local_normal_at,
    )
  end

  include Transformation::Ability
  attr_accessor :material

  def initialize(
    transform: RTMatrix::IDENTITY,
    material: Material.new,
    world: World.default
  )
    self.transform = transform
    @material = material
    world.objects << self
  end

  def intersect(ray)
    local_intersect(ray.transform(inverse_transform))
  end

  def normal_at(world_point)
    local_point = inverse_transform * world_point
    local_normal = local_normal_at(local_point) # To implement in inheriting classes
    world_normal = transposed_inverse_transform * local_normal
    world_normal.w = 0
    world_normal.normalize
  end
end
