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
    comps.object.material.lighting(light, comps.point, comps.eyev, comps.normalv)
  end

  def color_at(ray)
    intersections = intersect(ray)
    hit = intersections.hit
    return Color::BLACK unless hit
    comps = hit.prepare_computations(ray)
    shade_hit(comps)
  end
end
