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

Given("r{int} ← ray point {int}, {int}, {int}, vector {int}, {int}, {int}") do |int, int2, int3, int4, int5, int6, int7|
  (@r ||= {})[int] = Ray.new(
    Tuple.point(int2, int3, int4),
    Tuple.vector(int5, int6, int7)
  )
end

Given("m ← translation {int}, {int}, {int}") do |int, int2, int3|
  @m = Transformation.translation(int, int2, int3)
end

When("r{int} ← transform r{int}, m") do |int, int2|
  @r[int] = @r[int2].transform(@m)
end

Then("r{int}.origin = point {int}, {int}, {int}") do |int, int2, int3, int4|
  expect(@r[int].origin).to eq(Tuple.point(int2, int3, int4))
end

Then("r{int}.direction = vector {int}, {int}, {int}") do |int, int2, int3, int4|
  expect(@r[int].direction).to eq(Tuple.vector(int2, int3, int4))
end

Given("m ← scaling {int}, {int}, {int}") do |int, int2, int3|
  @m = Transformation.scaling(int, int2, int3)
end
