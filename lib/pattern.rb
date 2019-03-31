require 'transformation'
require 'duck_enforcer'

class Pattern
  class Specialization < DuckEnforcer
    implement :pattern_at
  end

  include Transformation::Ability

  def initialize(transform: RTMatrix::IDENTITY)
    self.transform = transform
  end

  def pattern_at_shape(shape, point)
    object_point = shape.inverse_transform * point
    pattern_point = inverse_transform * object_point
    pattern_at(pattern_point)
  end

  class Stripe < Pattern
    attr_reader :a, :b

    def initialize(a, b, **args)
      super(**args)
      @a = a
      @b = b
    end

    def pattern_at(point)
      (point.x.floor % 2).zero? ? a : b
    end
  end

  class Gradient < Pattern
    attr_reader :a, :b, :distance

    def initialize(a, b, **args)
      super(**args)
      @a = a
      @b = b
      @distance = b - a
    end

    def pattern_at(point)
      fraction = point.x - point.x.floor
      a + distance * fraction
    end
  end

  class Ring < Pattern
    attr_reader :a, :b

    def initialize(a, b, **args)
      super(**args)
      @a = a
      @b = b
    end

    def pattern_at(point)
      (Math.sqrt(point.x ** 2 + point.z ** 2).floor % 2).zero? ? a : b
    end
  end

  class Checkers < Pattern
    attr_reader :a, :b

    def initialize(a, b, **args)
      super(**args)
      @a = a
      @b = b
    end

    def pattern_at(point)
      ((point.x.floor + point.y.floor + point.z.floor) % 2).zero? ? a : b
    end
  end
end
