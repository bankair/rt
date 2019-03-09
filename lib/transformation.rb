require 'rtmatrix'

class Transformation
  class << self
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
