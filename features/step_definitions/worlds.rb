require 'world'
require 'byebug'

Given("w ← world") do
  @w = World.new
end

Then("w contains no objects") do
  expect(@w.objects).to be_empty
end

Then("w has no light source") do
  expect(@w.light).to be_nil
end

require 'byebug'
Given("s{int} ← sphere with:") do |int, table|
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
  (@s ||= {})[int] = sphere
end

When("w ← default_world") do
  @w = World.default
end

Then("w.light = light") do
  @w.light = @light
end

Then("w contains s{int}") do |int|
  expect(@w.objects.include?(@s[int])).to be(true)
end

Given("r ← ray point {int}, {int}, {int}, vector {int}, {int}, {int}") do |int, int2, int3, int4, int5, int6|
  @r = Ray.new(Tuple.point(int, int2, int3), Tuple.vector(int4, int5, int6))
end

When("xs ← intersect_world w, r") do
  @xs = @w.intersect(@r)
end

Given("shape ← the first object in w") do
  @shape = @w.objects.first
end

When("c ← shade_hit w, comps") do
  @c = @w.shade_hit(@comps)
end

Then("c = color {float}, {float}, {float}") do |float, float2, float3|
  expect(@c.red).to be_within(0.0001).of(float)
  expect(@c.green).to be_within(0.0001).of(float2)
  expect(@c.blue).to be_within(0.0001).of(float3)
end

Given("w.light ← point_light point {float}, {float}, {float}, color {float}, {float}, {float}") do |float, float2, float3, float4, float5, float6|
  @w.light = Light::Point.new(
    Tuple.point(float, float2, float3),
    Color.new(float4, float5, float6)
  )
end

Given("shape ← the second object in w") do
  @shape = @w.objects[1]
end

Given("i ← intersection {float}, shape") do |float|
  @i = Intersection.new(float, @shape)
end
