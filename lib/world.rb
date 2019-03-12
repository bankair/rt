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

  def intersect(ray)
    result = objects.map { |object| object.intersect(ray) }.reduce(&:+)
    result.sort_by!(&:t)
    result
  end

  def shade_hit(comps)
    comps.object.material.lighting(light, comps.point, comps.eyev, comps.normalv)
  end
end
