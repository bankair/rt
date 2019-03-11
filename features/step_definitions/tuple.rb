require 'tuple'

Given("a ← tuple {float}, {float}, {float}, {float}") do |float, float2, float3, float4|
  @a = Tuple.new(float, float2, float3, float4)
end

Then("a.x = {float}") do |float|
  expect(@a.x).to eq(float)
end

Then("a.y = {float}") do |float|
  expect(@a.y).to eq(float)
end

Then("a.z = {float}") do |float|
  expect(@a.z).to eq(float)
end

Then("a.w = {float}") do |float|
  expect(@a.w).to eq(float)
end

Then("a is a point") do
  expect(@a).to be_point
end

Then("a is not a vector") do
  expect(@a).to_not be_vector
end

Then("a is not a point") do
  expect(@a).to_not be_point
end

Then("a is a vector") do
  expect(@a).to be_vector
end

Given('p ← point {int}, {int}, {int}') do |int, int2, int3|
  @p = Tuple.point(int, int2, int3)
end

Then("p = tuple {int}, {int}, {int}, {int}") do |int, int2, int3, int4|
  expect(@p).to eq(Tuple.new(int, int2, int3, int4))
end

Given("v ← vector {int}, {int}, {int}") do |int, int2, int3|
  @v = Tuple.vector(int, int2, int3)
end

Then("v = tuple {int}, {int}, {int}, {int}") do |int, int2, int3, int4|
  expect(@v).to eq(Tuple.new(int, int2, int3, int4))
end

Given("a{int} ← tuple {int}, {int}, {int}, {int}") do |int, int2, int3, int4, int5|
  (@a ||= {})[int] = Tuple.new(int2, int3, int4, int5)
end

Then("a{int} + a{int} = tuple {int}, {int}, {int}, {int}") do |int, int2, int3, int4, int5, int6|
  expect(@a[int] + @a[int2]).to eq(Tuple.new(int3, int4, int5, int6))
end

Given("p{int} ← point {int}, {int}, {int}") do |int, int2, int3, int4|
  (@p ||= {})[int] = Tuple.point(int2, int3, int4)
end

Then("p{int} - p{int} = vector {int}, {int}, {int}") do |int, int2, int3, int4, int5|
  expect(@p[int] - @p[int2]).to eq(Tuple.vector(int3, int4, int5))
end

Then("p - v = point {int}, {int}, {int}") do |int, int2, int3|
  expect(@p - @v).to eq(Tuple.point(int, int2, int3))
end

Given("v{int} ← vector {int}, {int}, {int}") do |int, int2, int3, int4|
  (@v ||= {})[int] = Tuple.vector(int2, int3, int4)
end

Then("v{int} - v{int} = vector {int}, {int}, {int}") do |int, int2, int3, int4, int5|
  expect(@v[int] - @v[int2]).to eq(Tuple.vector(int3, int4, int5))
end

Given("zero ← vector {int}, {int}, {int}") do |int, int2, int3|
  @zero = Tuple.vector(0, 0, 0)
end

Then("zero - v = vector {int}, {int}, {int}") do |int, int2, int3|
  expect(@zero - @v).to eq(Tuple.vector(int, int2, int3))
end

Then("-a = tuple {float}, {float}, {float}, {float}") do |float, float2, float3, float4|
  expect(-@a).to eq(Tuple.new(float, float2, float3, float4))
end

Then("a * {float} = tuple {float}, {float}, {float}, {float}") do |float, float2, float3, float4, float5|
  expect(@a * float).to eq(Tuple.new(float2, float3, float4, float5))
end

Then("a \/ {float} = tuple {float}, {float}, {float}, {float}") do |float, float2, float3, float4, float5|
  expect(@a / float).to eq(Tuple.new(float2, float3, float4, float5))
end

Then("magnitude v = {int}") do |int|
  expect(@v.magnitude).to eq(int)
end

Then("magnitude v = √{int}") do |int|
  expect(@v.magnitude).to eq(Math.sqrt(int))
end

Then("normalize v = vector {int}, {int}, {int}") do |int, int2, int3|
  expect(@v.normalize).to eq(Tuple.vector(int, int2, int3))
end

Then("normalize v = approximately vector {float}, {float}, {float}") do |float, float2, float3|
  normalized_v = @v.normalize
  expect(normalized_v).to be_vector
  expect(normalized_v.x).to be_within(0.00001).of(0.26726)
  expect(normalized_v.y).to be_within(0.00001).of(0.53452)
  expect(normalized_v.z).to be_within(0.00001).of(0.80178)
end

When("norm ← normalize v") do
  @norm = @v.normalize
end

Then("magnitude norm = {int}") do |int|
  expect(@norm.magnitude).to eq(int)
end

Then("dot v{int}, v{int} = {int}") do |int, int2, int3|
  expect(@v[int].dot(@v[int2])).to eq(int3)
end

Then("cross v{int}, v{int} = vector {int}, {int}, {int}") do |int, int2, int3, int4, int5|
  expect(@v[int].cross(@v[int2])).to eq(Tuple.vector(int3, int4, int5))
end

Given("n ← vector {float}, {float}, {float}") do |float, float2, float3|
  @n = Tuple.vector(float, float2, float3)
end

When("r ← reflect v, n") do
  @r = @v.reflect(@n)
end

Then("r = vector {int}, {int}, {int}") do |int, int2, int3|
  expect(@r.x).to be_within(0.0001).of(int)
  expect(@r.y).to be_within(0.0001).of(int2)
  expect(@r.z).to be_within(0.0001).of(int3)
end
