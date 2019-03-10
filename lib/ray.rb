class Ray
  attr_reader :origin, :direction

  def initialize(origin, direction)
    @origin = origin
    @direction = direction
  end

  def position(time)
    origin + direction * time
  end
end
