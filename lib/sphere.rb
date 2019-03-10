require 'intersection'

class Sphere
  attr_reader :position, :radius

  def initialize(position: Tuple::Point::ORIGIN, radius: 1)
    @position = position
    @radius = radius
  end

  def intersect(ray)
    sphere_to_ray = ray.origin - Tuple::Point::ORIGIN
    a = ray.direction.dot(ray.direction)
    b = 2 * ray.direction.dot(sphere_to_ray)
    c = sphere_to_ray.dot(sphere_to_ray) - 1
    discriminant = b ** 2 - 4 * a * c
    return Intersection::Collection::EMPTY if discriminant < 0
    sqrt_discriminant = Math.sqrt(discriminant)
    Intersection[
      Intersection.new((-b - sqrt_discriminant) / (2 * a), self),
      Intersection.new((-b + sqrt_discriminant) / (2 * a), self)
    ]
  end
end
