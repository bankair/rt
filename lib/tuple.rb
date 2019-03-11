# Standard tuple (point and vector) class
require 'byebug'
class Tuple
  # rubocop:disable Naming/UncommunicativeMethodParamName
  attr_accessor :x, :y, :z, :w
  def initialize(x, y, z, w)
    self.x = x.to_f
    self.y = y.to_f
    self.z = z.to_f
    self.w = w.to_f
  end

  class << self
    def point(x, y, z)
      new(x, y, z, 1.0)
    end

    def vector(x, y, z)
      new(x, y, z, 0.0)
    end
  end

  module Point
    ORIGIN = Tuple.point(0.0, 0.0, 0.0).freeze
  end

  def point?
    w == 1.0
  end

  def vector?
    w == 0.0
  end

  def ==(other)
    x == other.x && y == other.y && z == other.z && w == other.w
  end

  def add(other)
  end

  def +(others)
    Array(others).reduce(self) do |result, other|
      self.class.new(x + other.x, y + other.y, z + other.z, w + other.w)
    end
  end

  def -(other)
    self.class.new(x - other.x, y - other.y, z - other.z, w - other.w)
  end

  def -@
    self.class.new(-x, -y, -z, -w)
  end

  def *(scalar) # rubocop:disable Naming/BinaryOperatorParameterName
    self.class.new(x * scalar, y * scalar, z * scalar, w * scalar)
  end

  def /(scalar) # rubocop:disable Naming/BinaryOperatorParameterName
    scalar = scalar.to_f
    self.class.new(x / scalar, y / scalar, z / scalar, w / scalar)
  end

  def magnitude
    Math.sqrt(x**2 + y**2 + z**2)
  end

  def normalize
    m = magnitude
    self.class.new(x / m, y / m, z / m, w)
  end

  def dot(other)
    x * other.x + y * other.y + z * other.z + w * other.w
  end

  def cross(other)
    self.class.vector(
      y * other.z - z * other.y,
      z * other.x - x * other.z,
      x * other.y - y * other.x
    )
  end

  def reflect(normal)
    self - normal * 2.0 * dot(normal)
  end
  # rubocop:enable Naming/UncommunicativeMethodParamName
end
