require 'matrix'
require 'tuple'

class RTMatrix < Matrix
  IDENTITY = RTMatrix[
    [1,0,0,0],
    [0,1,0,0],
    [0,0,1,0],
    [0,0,0,1],
  ].freeze

  def *(other)
    if other.is_a?(Tuple)
      (self * Matrix[[other.x], [other.y], [other.z], [other.w]]).to_tuple
    else
      super
    end
  end

  def to_tuple
    Tuple.new(self[0, 0], self[1, 0], self[2, 0], self[3, 0])
  end

  def submatrix(row, column)
    first_minor(row, column)
  end

  def self.minor(matrix, row, column)
    matrix.submatrix(row, column).determinant
  end

  def minor(*_args)
    unless @matrix_minor_warning_issued
      warn 'RTMatrix#minor does not calculate the determinant of the submatrix. '\
        'Use RTMatrix.minor for that.'
      @matrix_minor_warning_issued = true
    end
    super
  end

  def invertible?
    !determinant.zero?
  end
end
