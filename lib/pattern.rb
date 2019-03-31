require 'transformation'

class Pattern
  class Stripe
    attr_reader :a, :b
    include Transformation::Ability

    def initialize(a, b, transform: RTMatrix::IDENTITY)
      @a = a
      @b = b
      self.transform = transform
    end

    def stripe_at(point)
      (point.x.floor % 2).zero? ? a : b
    end

    def stripe_at_object(object, world_point)
      object_point = object.inverse_transform * world_point
      pattern_point = inverse_transform * object_point
      return stripe_at(pattern_point)
    end
  end
end
