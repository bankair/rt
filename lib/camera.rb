require 'rtmatrix'
require 'canvas'

# Allow camera manipulation and rendering
class Camera
  NO_TRANSFORMATION = RTMatrix.identity(4)
  attr_reader :hsize, :vsize, :field_of_view
  # needed for calculations:
  attr_reader :half_view, :half_height, :half_width, :pixel_size
  attr_accessor :transform

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

  def ray_for_pixel(px, py)
    xoffset = (px + 0.5) * pixel_size
    yoffset = (py + 0.5) * pixel_size
    world_x = half_width - xoffset
    world_y = half_height - yoffset
    pixel = transform.inverse * Tuple.point(world_x, world_y, -1.0)
    origin = transform.inverse * Tuple.point(0.0, 0.0, 0.0)
    direction = (pixel - origin).normalize
    return Ray.new(origin, direction)
  end

  def render(world)
    image = Canvas.new(hsize, vsize)
    (0...vsize).each do |y|
      (0...hsize).each do |x|
        image[x, y] = world.color_at(ray_for_pixel(x, y))
      end
    end
    image
  end
end
