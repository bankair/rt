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
