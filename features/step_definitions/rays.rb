require 'ray'

Given("origin ← point {int}, {int}, {int}") do |int, int2, int3|
  @origin = Tuple.point(int, int2, int3)
end

Given("direction ← vector {int}, {int}, {int}") do |int, int2, int3|
  @direction = Tuple.vector(int, int2, int3)
end

When("r ← ray origin, direction") do
  @r = Ray.new(@origin, @direction)
end

Then("r.origin = origin") do
  expect(@r.origin).to eq(@origin)
end

Then("r.direction = direction") do
  expect(@r.direction).to eq(@direction)
end

Given("r ← ray point {float}, {float}, {float}, vector {float}, {float}, {float}") do |float, float2, float3, float4, float5, float6|
  @r = Ray.new(Tuple.point(float, float2, float3), Tuple.vector(float4, float5, float6))
end

Then("position r, {float} = point {float}, {float}, {float}") do |float, float2, float3, float4|
  expect(@r.position(float)).to eq(Tuple.point(float2, float3, float4))
end

