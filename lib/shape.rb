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

  attr_accessor :transform, :material

  def initialize(transform: RTMatrix::IDENTITY, material: Material.new)
    @transform = transform
    @material = material
  end

  def intersect(ray)
    local_intersect(ray.transform(transform.inverse))
  end

  def normal_at(world_point)
    local_point = transform.inverse * world_point
    local_normal = local_normal_at(local_point) # To implement in inheriting classes
    world_normal = transform.inverse.transpose * local_normal
    world_normal.w = 0
    world_normal.normalize
  end
end
