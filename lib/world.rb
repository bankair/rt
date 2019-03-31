class World
  attr_accessor :light
  attr_reader :objects

  def initialize(objects: [], light: nil)
    @objects = objects
    @light = light
  end

  def self.default
    @default ||= new
  end

  def self.default=(value)
    @default = value
  end

  def intersect(ray)
    result = Intersection::Collection.new
    objects.each do |object|
      Array(object.intersect(ray)).each { |intersection| result << intersection }
    end
    result.sort_by!(&:t)
    result
  end

  def shade_hit(comps)
    shadowed = is_shadowed(comps.over_point)
    comps.object.material.lighting(
      comps.object,
      light,
      comps.point,
      comps.eyev,
      comps.normalv,
      shadowed
    )
  end

  def color_at(ray)
    intersections = intersect(ray)
    hit = intersections.hit
    return Color::BLACK unless hit
    comps = hit.prepare_computations(ray)
    shade_hit(comps)
  end

  def is_shadowed(point)
    v = light.position - point
    distance = v.magnitude
    direction = v.normalize
    r = Ray.new(point, direction)
    intersections = intersect(r)
    h = intersections.hit
    h && h.t < distance ? true : false
  end
end
