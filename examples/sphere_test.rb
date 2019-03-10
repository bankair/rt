require 'canvas'
require 'sphere'
require 'ray'

class SphereTest
  attr_reader :canvas, :sphere

  WALL_Z = 10.0
  WALL_SIZE = 7.0
  HALF = WALL_SIZE / 2
  CANVAS_PIXELS = 100
  PIXEL_SIZE = WALL_SIZE / CANVAS_PIXELS
  COLOR = Color.new(1, 0, 0)

  def initialize
    @canvas = Canvas.new(CANVAS_PIXELS, CANVAS_PIXELS)
    @sphere = Sphere.new
  end

  def run
    ray_origin = Tuple.point(0, 0, -5)
    (0...CANVAS_PIXELS).each do |y|
      world_y = HALF - PIXEL_SIZE * y
      (0...CANVAS_PIXELS).each do |x|
        world_x = -HALF + PIXEL_SIZE * x
        position = Tuple.point(world_x, world_y, WALL_Z)
        r = Ray.new(ray_origin, (position - ray_origin).normalize)
        xs = sphere.intersect(r)
        hit = xs.hit
        canvas[x, y] = Color.new(rand, rand, rand) if hit
      end
    end
    File.write('sphere_test.ppm', canvas.to_ppm)
    system('open sphere_test.ppm')
  end
end

SphereTest.new.run
