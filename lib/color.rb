# Represent a color
class Color
  attr_reader :red, :green, :blue

  def initialize(red, green, blue)
    @red = red.to_f
    @green = green.to_f
    @blue = blue.to_f
  end

  BLACK = Color.new(0, 0, 0).freeze
  RED = Color.new(1, 0, 0).freeze
  GREEN = Color.new(0, 1, 0).freeze
  BLUE = Color.new(0, 0, 1).freeze

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
    self.class.new(red - other.red, green - other.green, blue - other.blue)
  end

  def *(scalar_or_color)
    scalar_or_color.is_a?(self.class) ? mult_color(scalar_or_color) : mult_scalar(scalar_or_color)
  end

  private

  def mult_scalar(scalar)
    self.class.new(red * scalar, green * scalar, blue * scalar)
  end

  def mult_color(color)
    self.class.new(red * color.red, green * color.green, blue * color.blue)
  end
end
