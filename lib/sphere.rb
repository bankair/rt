require 'shape'
require 'intersection'
require 'tuple'
require 'rtmatrix'
require 'material'
require 'world'

class Sphere < Shape
  attr_reader :position, :radius
  attr_accessor :material

  def initialize(
    position: Tuple::Point::ORIGIN,
    radius: 1,
    **args
  )
    super(**args)
    @position = position
    @radius = radius.to_f
  end

  def local_intersect(ray)
    sphere_to_ray = ray.origin - Tuple::Point::ORIGIN
    a = ray.direction.dot(ray.direction)
    b = 2.0 * ray.direction.dot(sphere_to_ray)
    c = sphere_to_ray.dot(sphere_to_ray) - 1
    discriminant = b ** 2 - 4 * a * c
    return Intersection::Collection::EMPTY if discriminant < 0
    sqrt_discriminant = Math.sqrt(discriminant)
    Intersection[
      Intersection.new((-b - sqrt_discriminant) / (2 * a), self),
      Intersection.new((-b + sqrt_discriminant) / (2 * a), self)
    ]
  end

  def local_normal_at(local_point)
    local_point - position
  end

  quacks_like_a! Shape::Specialization
end
