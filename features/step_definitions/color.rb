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

Given("c{int} ← color {float}, {float}, {float}") do |int, float, float2, float3|
  (@c ||= {})[int] = Color.new(float, float2, float3)
end

Then("c{int} + c{int} = color {float}, {float}, {float}") do |int, int2, float, float2, float3|
  expect(@c[int] + @c[int2]).to eq(Color.new(float, float2, float3))
end

Then("c{int} - c{int} = color {float}, {float}, {float}") do |int, int2, float, float2, float3|
  color = @c[int] - @c[int2]
  expect(color.red).to be_within(0.00001).of(float)
  expect(color.green).to be_within(0.00001).of(float2)
  expect(color.blue).to be_within(0.00001).of(float3)
end

Then("c * {int} = color {float}, {float}, {float}") do |int, float, float2, float3|
  expect(@c * int).to eq(Color.new(float, float2, float3))
end

Then("c{int} * c{int} = color {float}, {float}, {float}") do |int, int2, float, float2, float3|
  color = @c[int] * @c[int2]
  expect(color.red).to be_within(0.00001).of(float)
  expect(color.green).to be_within(0.00001).of(float2)
  expect(color.blue).to be_within(0.00001).of(float3)
end
