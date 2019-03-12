class Intersection
  attr_reader :t, :object

  def initialize(t, object)
    @t = t
    @object = object
  end

  class Comps
    attr_reader :t, :object, :point, :eyev, :normalv, :inside

    def initialize(intersection, ray)
      @t = intersection.t
      @object = intersection.object
      @point = ray.position(@t)
      @eyev = -ray.direction
      @normalv = @object.normal_at(@point)
      @inside = false
      if @normalv.dot(@eyev) < 0
        @inside = true
        @normalv = -@normalv
      end
    end
  end

  def prepare_computations(ray)
    Comps.new(self, ray)
  end

  def self.[](*intersections)
    Collection.new(intersections)
  end

  class Collection < Array
    EMPTY = Intersection[].freeze

    def hit
      result = nil
      each do |intersection|
        if intersection.t >= 0 && (result.nil? || result.t > intersection.t)
          result = intersection
        end
      end
      result
    end
  end
end
