require 'progress_bar'
require 'sphere'
require 'plane'
require 'transformation'
require 'light'
require 'camera'
require 'pattern'

class Scene
  # Floor and walls:
  FLOOR_MATERIAL = Material.new(pattern: Pattern::Ring.new(Color::WHITE, Color::BLACK), specular: 0).freeze
  FLOOR = Plane.new(material: FLOOR_MATERIAL)
  WALL_MATERIAL = Material.new(pattern: Pattern::Gradient.new(Color::GREEN, Color::BLUE), specular: 0).freeze
  WALL = Plane.new(
    material: WALL_MATERIAL,
    transform:  Transformation.translation(0, 0, 2) * Transformation.rotation_x(Math::PI / 2)

  )

  # Spheres:
  MIDDLE_SPHERE = Sphere.new(
    transform: Transformation.translation(-0.5, 1, 0.5),
    material: Material.new(
      color: Color.new(0.1, 1, 0.5),
      diffuse: 0.7,
      specular: 0.3,
      pattern: Pattern::Stripe.new(
        Color::BLUE,
        Color::GREEN,
        transform: Transformation.rotation_z(Math::PI / 4)
      )
    )
  )
  RIGHT_SPHERE = Sphere.new(
    transform: Transformation.translation(1.5, 0.5, -0.5) * Transformation.scaling(0.5, 0.5, 0.5),
    material: Material.new(
      color: Color.new(0.5, 1, 0.1),
      diffuse: 0.7,
      specular: 0.3,
    )
  )
  LEFT_SPHERE = Sphere.new(
    transform: Transformation.translation(-1.5, 0.33, -0.75) * Transformation.scaling(0.33, 0.33, 0.33),
    material: Material.new(pattern: Pattern::Checkers.new(Color::BLACK, Color::WHITE), diffuse: 0.7, specular: 0.3)
  )

  World.default.light = Light::Point.new(Tuple.point(-10, 10, -10), Color.new(1, 1, 1))

  WIDTH = 300
  HEIGHT = 150
  FOV = Math::PI/3

  def self.render!
    camera =
      Camera.new(
        WIDTH,
        HEIGHT,
        FOV,
        transform: Transformation.view_transform(
          Tuple.point(0, 1.5, -5),
          Tuple.point(0, 1, 0),
          Tuple.vector(0, 1, 0)
        )

    )
    # render the result to a canvas.
    bar = ProgressBar.new(WIDTH * HEIGHT, :bar, :rate, :eta)
    max_x = WIDTH - 1
    t = Time.now
    canvas = camera.render(World.default) { |x, y| bar.increment!(WIDTH) if x == max_x }
    puts "Rendered #{WIDTH*HEIGHT} pixels in #{Time.now - t} seconds"
    File.write('scene_test.ppm', canvas.to_ppm)
    system('open scene_test.ppm')
  end
end

Scene.render!
