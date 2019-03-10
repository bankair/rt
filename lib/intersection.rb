class Intersection
  attr_reader :t, :object

  def initialize(t, object)
    @t = t
    @object = object
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
