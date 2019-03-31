require 'rtmatrix'

class Transformation
  # Utility module to memoize transform and inverse
  module Ability
    def transform
      @transform_value
    end

    def transform=(new_transform)
      @transform_value = new_transform
      @inverse_transform_value = new_transform.inverse
      @transposed_inverse_transform_value = @inverse_transform_value.transpose
    end

    def inverse_transform
      @inverse_transform_value
    end

    def transposed_inverse_transform
      @transposed_inverse_transform_value
    end
  end

  class << self
    def view_transform(from, to, up)
      forward = (to - from).normalize
      left = forward.cross(up.normalize)
      true_up = left.cross(forward)
      orientation = RTMatrix[
        [left.x, left.y, left.z, 0],
        [true_up.x, true_up.y, true_up.z, 0],
        [-forward.x, -forward.y, -forward.z, 0],
        [0, 0, 0, 1]
      ]
      orientation * translation(-from.x, -from.y, -from.z)
    end

    def translation(x, y, z)
      RTMatrix[
        [1, 0, 0, x],
        [0, 1, 0, y],
        [0, 0, 1, z],
        [0, 0, 0, 1],
      ]
    end

    def scaling(x, y, z)
      RTMatrix[
        [x, 0, 0, 0],
        [0, y, 0, 0],
        [0, 0, z, 0],
        [0, 0, 0, 1],
      ]
    end

    def rotation_x(radians)
      cos = Math.cos(radians)
      sin = Math.sin(radians)
      RTMatrix[
        [1, 0  , 0   , 0],
        [0, cos, -sin, 0],
        [0, sin, cos , 0],
        [0, 0  , 0   , 1],
      ]
    end

    def rotation_y(radians)
      cos = Math.cos(radians)
      sin = Math.sin(radians)
      RTMatrix[
        [cos , 0, sin, 0],
        [0   , 1, 0  , 0],
        [-sin, 0, cos, 0],
        [0   , 0, 0  , 1],
      ]
    end

    def rotation_z(radians)
      cos = Math.cos(radians)
      sin = Math.sin(radians)
      RTMatrix[
        [cos, -sin, 0, 0],
        [sin, cos , 0, 0],
        [0  , 0   , 1, 0],
        [0  , 0   , 0, 1],
      ]
    end

    def shearing(xy, xz, yx, yz, zx, zy)
      RTMatrix[
        [1, xy, xz, 0],
        [yx, 1, yz, 0],
        [zx, zy, 1, 0],
        [0, 0, 0, 1],
      ]
    end
  end
end
