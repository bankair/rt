require 'rtmatrix'
class Camera
  NO_TRANSFORMATION = RTMatrix.identity(4)
  attr_reader :hsize, :vsize, :field_of_view, :transform
  # needed for calculations:
  attr_reader :half_view, :half_height, :half_width, :pixel_size

  def initialize(hsize, vsize, field_of_view, transform: NO_TRANSFORMATION)
    @hsize = hsize
    @vsize = vsize
    @field_of_view = field_of_view.to_f
    @transform = transform
    @half_view = Math.tan(@field_of_view / 2)
    aspect = hsize.to_f / vsize
    @half_width, @half_height =
      if aspect >= 1 then
        [@half_view, @half_view / aspect]
      else
        [@half_view * aspect, @half_view]
      end
    @pixel_size = (half_width * 2) / hsize
  end
end
