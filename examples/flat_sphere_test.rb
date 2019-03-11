require 'canvas'
require 'sphere'
require 'ray'
require 'transformation'

class SphereTest
  attr_reader :canvas, :sphere

  WALL_Z = 10.0
  WALL_SIZE = 7.0
  HALF = WALL_SIZE / 2
  CANVAS_PIXELS = 100
  PIXEL_SIZE = WALL_SIZE / CANVAS_PIXELS

  def initialize
    @canvas = Canvas.new(CANVAS_PIXELS, CANVAS_PIXELS)
    @sphere = Sphere.new
  end

  def run
    sphere.transform = Transformation.shearing(1, 0, 0, 0, 0, 0) * Transformation.scaling(0.5, 1, 1)
    ray_origin = Tuple.point(0, 0, -5)
    (0...CANVAS_PIXELS).each do |y|
      world_y = HALF - PIXEL_SIZE * y
      (0...CANVAS_PIXELS).each do |x|
        world_x = -HALF + PIXEL_SIZE * x
        position = Tuple.point(world_x, world_y, WALL_Z)
        r = Ray.new(ray_origin, (position - ray_origin).normalize)
        xs = sphere.intersect(r)
        hit = xs.hit
        next unless hit
        canvas[x, y] = Color.new(1 - (hit.t - 4), 0, 0)
      end
    end
    File.write('sphere_test.ppm', canvas.to_ppm)
    system('open sphere_test.ppm')
  end
end

SphereTest.new.run
