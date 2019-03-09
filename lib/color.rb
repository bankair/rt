# Represent a color
class Color
  attr_accessor :red, :green, :blue

  def initialize(red, green, blue)
    self.red = red
    self.green = green
    self.blue = blue
  end

  def ==(other)
    return false unless other.is_a?(self.class)
    red == other.red && green == other.green && blue == other.blue
  end

  def +(others)
    Array(others).reduce(self) do |result, color|
      self.class.new(
        result.red + color.red,
        result.green + color.green,
        result.blue + color.blue
      )
    end
  end

  def -(other)
    self.class.new(
      red - other.red,
      green - other.green,
      blue - other.blue
    )
  end

  def *(scalar)
    self.class.new(red * scalar, green * scalar, blue * scalar)
  end
end
