require 'shape'

class Plane < Shape
  NORMAL = Tuple.vector(0, 1, 0)

  def local_normal_at(_local_point)
    NORMAL
  end

  def local_intersect(ray)
    return Intersection::Collection::EMPTY if ray.direction.y.abs < Intersection::EPSILON
    Intersection[Intersection.new(-ray.origin.y / ray.direction.y, self)]
  end
end
