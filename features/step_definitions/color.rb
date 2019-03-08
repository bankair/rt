require 'color'

Given("c ← color {float}, {float}, {float}") do |float, float2, float3|
  @c = Color.new(float, float2, float3)
end

Then("c.red = {float}") do |float|
  expect(@c.red).to eq(float)
end

Then("c.green = {float}") do |float|
  expect(@c.green).to eq(float)
end

Then("c.blue = {float}") do |float|
  expect(@c.blue).to eq(float)
end
