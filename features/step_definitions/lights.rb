require 'light'

Given("intensity ← color {int}, {int}, {int}") do |int, int2, int3|
  @intensity = Color.new(int, int2, int3)
end

Given("position ← point {int}, {int}, {int}") do |int, int2, int3|
  @position = Tuple.point(int, int2, int3)
end

When("light ← point_light position, intensity") do
  @light = Light::Point.new(@position, @intensity)
end

Then("light.position = position") do
  expect(@light.position).to eq(@position)
end

Then("light.intensity = intensity") do
  expect(@light.intensity).to eq(@intensity)
end
