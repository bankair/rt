require 'material'

Given("m ← material") do
  @m = Material.new
end

Then("m.color = color {int}, {int}, {int}") do |int, int2, int3|
  expect(@m.color).to eq(Color.new(int, int2, int3))
end

Then("m.ambient = {float}") do |float|
  expect(@m.ambient).to eq(float)
end

Then("m.diffuse = {float}") do |float|
  expect(@m.diffuse).to eq(float)
end

Then("m.specular = {float}") do |float|
  expect(@m.specular).to eq(float)
end

Then("m.shininess = {float}") do |float|
  expect(@m.shininess).to eq(float)
end

Given("eyev ← vector {float}, {float}, {float}") do |float, float2, float3|
  @eyev = Tuple.vector(float, float2, float3)
end

Given("normalv ← vector {float}, {float}, {float}") do |float, float2, float3|
  @normalv = Tuple.vector(float, float2, float3)
end

Given("light ← point_light point {int}, {int}, {int}, color {int}, {int}, {int}") do |int, int2, int3, int4, int5, int6|
  @light = Light::Point.new(
    Tuple.point(int, int2, int3),
    Color.new(int4, int5, int6)
  )
end

When("result ← lighting m, light, position, eyev, normalv") do
  @result = @m.lighting(@light, @position, @eyev, @normalv)
end

Then("result = color {float}, {float}, {float}") do |float, float2, float3|
  expect(@result.red).to be_within(0.001).of(float)
  expect(@result.green).to be_within(0.001).of(float2)
  expect(@result.blue).to be_within(0.001).of(float3)
end

Given("in_shadow ← true") do
  @in_shadow = true
end

When("result ← lighting m, light, position, eyev, normalv, in_shadow") do
  @result = @m.lighting(@light, @position, @eyev, @normalv, @in_shadow)
end
