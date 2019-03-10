class Ray
  attr_reader :origin, :direction

  def initialize(origin, direction)
    @origin = origin
    @direction = direction
  end

  def position(time)
    origin + direction * time
  end

  def transform(matrix)
    Ray.new(matrix * origin, matrix * direction)
  end
end
