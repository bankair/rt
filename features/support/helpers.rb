module Helpers
  def epsilon
    0.0001
  end

  def build_sphere_from(table)
    build_from(Sphere.new, table)
  end

  def build_from(shape, table)
    material = shape.material
    table.raw.each do |key, value|
      case key
      when 'material.color'
        material.color = Color.new(*value.split(/, /).map(&:to_f))
      when 'material.diffuse'
        material.diffuse = value.to_f
      when 'material.specular'
        material.specular = value.to_f
      when 'material.reflective'
        material.reflective = value.to_f
      when 'transform'
        method, *args = value.split(/,? /)
        args.map!(&:to_f)
        shape.transform = Transformation.send(method, *args)
      else
        raise "Unmanaged use case: #{key} => #{value}"
      end
    end
    shape
  end
end

World(Helpers)



