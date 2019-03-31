require 'color'

class Material
  DEFAULT_COLOR = Color.new(1, 1, 1).freeze
  DEFAULT_AMBIENT = 0.1
  DEFAULT_DIFFUSE = 0.9
  DEFAULT_SPECULAR = 0.9
  DEFAULT_SHININESS = 200.0

  attr_accessor :ambient, :color, :diffuse, :specular, :shininess, :pattern, :reflective

  def initialize(
    color: DEFAULT_COLOR,
    ambient: DEFAULT_AMBIENT,
    diffuse: DEFAULT_DIFFUSE,
    specular: DEFAULT_SPECULAR,
    shininess: DEFAULT_SHININESS,
    pattern: nil,
    reflective: 0.0
  )
    @color = color
    @ambient = ambient
    @diffuse = diffuse
    @specular = specular
    @shininess = shininess
    @pattern = pattern
    @reflective = reflective
  end

  def ==(other)
    color == other.color &&
      ambient == other.ambient &&
      diffuse == other.diffuse &&
      specular == other.specular &&
      shininess == other.shininess
  end

  def lighting(object, light, point, eyev, normalv, in_shadow)
    local_color = pattern ? pattern.pattern_at_shape(object, point) : color
    effective_color = local_color * light.intensity
    lightv = (light.position - point).normalize
    ambient_color = effective_color * ambient
    light_dot_normal = lightv.dot(normalv)
    if in_shadow || light_dot_normal < 0
      diffuse_color = Color::BLACK
      specular_color = Color::BLACK
    else
      diffuse_color = effective_color * diffuse * light_dot_normal
      reflectv = (-lightv).reflect(normalv)
      reflect_dot_eye = reflectv.dot(eyev)
      if reflect_dot_eye <= 0
        specular_color = Color::BLACK
      else
        factor = reflect_dot_eye ** shininess
        specular_color = light.intensity * specular * factor
      end
    end
    ambient_color + diffuse_color + specular_color
  end
end
