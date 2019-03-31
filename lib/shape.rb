require 'rtmatrix'

# Base shape class
class Shape
  attr_accessor :transform, :material

  def initialize(transform: RTMatrix::IDENTITY, material: Material.new)
    @transform = transform
    @material = material
  end

  def intersect(ray)
    local_intersect(ray.transform(transform.inverse))
  end
end
