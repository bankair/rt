def build_sphere_from(table)
  sphere = Sphere.new
  material = sphere.material
  table.raw.each do |key, value|
    case key
    when 'material.color'
      material.color = Color.new(*value.split(/, /).map(&:to_f))
    when 'material.diffuse'
      material.diffuse = value.to_f
    when 'material.specular'
      material.specular = value.to_f
    when 'transform'
      method, *args = value.split(/,? /)
      args.map!(&:to_f)
      sphere.transform = Transformation.send(method, *args)
    else
      raise 'Unmanaged use case'
    end
  end
  sphere
end
