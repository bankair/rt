class Material
  DEFAULT_COLOR = Color.new(1, 1, 1).freeze
  DEFAULT_AMBIENT = 0.1
  DEFAULT_DIFFUSE = 0.9
  DEFAULT_SPECULAR = 0.9
  DEFAULT_SHININESS = 200.0

  attr_reader :color, :diffuse, :specular, :shininess
  attr_accessor :ambient

  def initialize(
    color: DEFAULT_COLOR,
    ambient: DEFAULT_AMBIENT,
    diffuse: DEFAULT_DIFFUSE,
    specular: DEFAULT_SPECULAR,
    shininess: DEFAULT_SHININESS
  )
    @color = color
    @ambient = ambient
    @diffuse = diffuse
    @specular = specular
    @shininess = shininess
  end

  def ==(other)
    color == other.color &&
      ambient == other.ambient &&
      diffuse == other.diffuse &&
      specular == other.specular &&
      shininess == other.shininess
  end
end
