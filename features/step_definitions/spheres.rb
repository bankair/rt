require 'sphere'

Given("s ← sphere") do
  @s = Sphere.new
end

When("xs ← intersect s, r") do
  @xs = @s.intersect(@r)
end

Then("xs.count = {int}") do |int|
  expect(@xs.count).to eq(int)
end

Then("xs[{int}].t = {float}") do |int, float|
  expect(@xs[int].t).to eq(float)
end

Then("xs[{int}].object = s") do |int|
  expect(@xs[int].object).to be(@s)
end

Then("s.transform = identity_matrix") do
  expect(@s.transform).to eq(RTMatrix::IDENTITY)
end

Given("t ← translation {int}, {int}, {int}") do |int, int2, int3|
  @t = Transformation.translation(int, int2, int3)
end

When("set_transform s, t") do
  @s.transform = @t
end

Then("s.transform = t") do
  expect(@s.transform).to eq @t
end

When("set_transform s, scaling {int}, {int}, {int}") do |int, int2, int3|
  @s.transform = Transformation.scaling(int, int2, int3)
end

When("set_transform s, translation {int}, {int}, {int}") do |int, int2, int3|
  @s.transform = Transformation.translation(int, int2, int3)
end

When("n ← normal_at s, point {float}, {float}, {float}") do |float, float2, float3|
  @n = @s.normal_at(Tuple.point(float, float2, float3))
end

Then("n = vector {float}, {float}, {float}") do |float, float2, float3|
  expect(@n.x).to be_within(0.00001).of(float)
  expect(@n.y).to be_within(0.00001).of(float2)
  expect(@n.z).to be_within(0.00001).of(float3)
end

Then("n = normalize n") do
  expect(@n).to eq(@n.normalize)
end
