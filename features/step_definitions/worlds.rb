require 'world'

Given("w ← world") do
  @w = World.new
end

Then("w contains no objects") do
  expect(@w.objects).to be_empty
end

Then("w has no light source") do
  expect(@w.light).to be_nil
end

Given("s{int} ← sphere with:") do |int, table|
  (@s ||= {})[int] = build_sphere_from(table)
end

When("w ← default_world") do
  @w = (World.default = World.new)
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
  expect(@c.red).to be_within(epsilon).of(float)
  expect(@c.green).to be_within(epsilon).of(float2)
  expect(@c.blue).to be_within(epsilon).of(float3)
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

When("c ← color_at w, r") do
  @c = @w.color_at(@r)
end

Then("c = color {int}, {int}, {int}") do |int, int2, int3|
  expect(@c.red).to be_within(epsilon).of(int)
  expect(@c.green).to be_within(epsilon).of(int2)
  expect(@c.blue).to be_within(epsilon).of(int3)
end

Given("outer ← the first object in w") do
  @outer = @w.objects.first
end

Given("outer.material.ambient ← {int}") do |int|
  @outer.material.ambient = int
end

Given("inner ← the second object in w") do
  @inner = @w.objects[1]
end

Given("inner.material.ambient ← {int}") do |int|
  @inner.material.ambient = int
end

Then("c = inner.material.color") do
  expected = @inner.material.color
  expect(@c.red).to be_within(epsilon).of(expected.red)
  expect(@c.green).to be_within(epsilon).of(expected.green)
  expect(@c.blue).to be_within(epsilon).of(expected.blue)
end


Then("is_shadowed w, p is false") do
  expect(@w.is_shadowed(@p)).to be(false)
end

Then("is_shadowed w, p is true") do
  expect(@w.is_shadowed(@p)).to be(true)
end

Given("w.light ← point_light point {int}, {int}, {int}, color {int}, {int}, {int}") do |int, int2, int3, int4, int5, int6|
  @w.light = Light::Point.new(
    Tuple.point(int, int2, int3),
    Color.new(int4, int5, int6)
  )
end

Given("s{int} ← sphere") do |int|
  (@s ||= {})[int] = Sphere.new
end

Given("s{int} is added to w") do |int|
  @w.objects << @s[int]
end

Given("i ← intersection {int}, s{int}") do |int, int2|
  @i = Intersection.new(int, @s[int2])
end

Given("shape.material.ambient ← {float}") do |float|
  @shape.material.ambient = float
end

When("color ← reflected_color w, comps") do
  @color = @w.reflected_color(@comps)
end

Then("color = color {float}, {float}, {float}") do |float, float2, float3|
  expect(@color).to eq(Color.new(float, float2, float3))
end
