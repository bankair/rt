require 'canvas'

Given("c ← canvas {int}, {int}") do |int, int2|
  @c = Canvas.new(int, int2)
end

Given("canvas ← canvas {int}, {int}") do |int, int2|
  @c = Canvas.new(int, int2)
end

Then("c.width = {int}") do |int|
  expect(@c.width).to eq(int)
end

Then("c.height = {int}") do |int|
  expect(@c.height).to eq(int)
end

Then("every pixel of c is color {int}, {int}, {int}") do |int, int2, int3|
  @c.each_pixel { |color| expect(color).to eq(Color::BLACK) }
end

Given("red ← color {int}, {int}, {int}") do |int, int2, int3|
  @red = Color.new(int, int2, int3)
end

When("write_pixel c, {int}, {int}, red") do |int, int2|
  @c[int, int2] = @red
end

Then("pixel_at c, {int}, {int} = red") do |int, int2|
  expect(@c[int, int2]).to eq(@red)
end

When("ppm ← canvas_to_ppm c") do
  @ppm = @c.to_ppm
end

Then("lines {int} to {int} of ppm are") do |int, int2, string|
  expected = string.split(/\n/)
  actual = @ppm.split(/\n/)[int-1..int2-1]
  expect(actual).to eq(expected)
end

When("write_pixel c {int}, {int}, color {float}, {float}, {float}") do |int, int2, float, float2, float3|
  @c[int, int2] = Color.new(float, float2, float3)
end

Given("c ← canvas {int}, {int} with every pixel of c set to color {float}, {float}, {float}") do |int, int2, float, float2, float3|
  @c = Canvas.new(int, int2, default_color: Color.new(float, float2, float3))
end

Then("ppm ends with a newline character") do
  expect(@ppm[-1]).to eq("\n")
end
