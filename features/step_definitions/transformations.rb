require 'transformation'

Given("transform ← translation {int}, {int}, {int}") do |int, int2, int3|
  @transform = Transformation.translation(int, int2, int3)
end

Then("transform * p = point {int}, {int}, {int}") do |int, int2, int3|
  expect(@transform * @p).to eq(Tuple.point(int, int2, int3))
end

Given("inv ← inverse transform") do
  @inv = @transform.inverse
end

Then("inv * p = point {int}, {int}, {int}") do |int, int2, int3|
  expect(@inv * @p).to eq(Tuple.point(int, int2, int3))
end

Then("transform * v = v") do
  expect(@transform * @v).to eq(@v)
end

Given("transform ← scaling {int}, {int}, {int}") do |int, int2, int3|
  @transform = Transformation.scaling(int, int2, int3)
end

Then("transform * v = vector {int}, {int}, {int}") do |int, int2, int3|
  expect(@transform * @v).to eq(Tuple.vector(int, int2, int3))
end

Then("inv * v = vector {int}, {int}, {int}") do |int, int2, int3|
  expect(@inv * @v).to eq(Tuple.vector(int, int2, int3))
end

Given("transform ← rotation_x π div {int}") do |int|
  @transform = Transformation.rotation_x(Math::PI / int)
end

Then("transform * p = point {float}, {float}, {float}") do |float, float2, float3|
  actual = @transform * @p
  expect(actual).to be_point
  expect(actual.x).to be_within(0.0001).of(float)
  expect(actual.y).to be_within(0.0001).of(float2)
  expect(actual.z).to be_within(0.0001).of(float3)
end

Then("inv * p = point {float}, {float}, {float}") do |float, float2, float3|
  actual = @inv * @p
  expect(actual).to be_point
  expect(actual.x).to be_within(0.0001).of(float)
  expect(actual.y).to be_within(0.0001).of(float2)
  expect(actual.z).to be_within(0.0001).of(float3)
end

Given("transform ← rotation_y π div {int}") do |int|
  @transform = Transformation.rotation_y(Math::PI / int)
end

Given("transform ← rotation_z π div {int}") do |int|
  @transform = Transformation.rotation_z(Math::PI / int)
end

Given("transform ← shearing {int}, {int}, {int}, {int}, {int}, {int}") do |int, int2, int3, int4, int5, int6|
  @transform = Transformation.shearing(int, int2, int3, int4, int5, int6)
end

Given("t{int} ← rotation_x π div {int}") do |int, int2|
  (@t ||= {})[int] = Transformation.rotation_x(Math::PI / int2)
end

Given("t{int} ← scaling {int}, {int}, {int}") do |int, int2, int3, int4|
  (@t ||= {})[int] = Transformation.scaling(int2, int3, int4)
end

Given("t{int} ← translation {int}, {int}, {int}") do |int, int2, int3, int4|
  (@t ||= {})[int] = Transformation.translation(int2, int3, int4)
end

When("p{int} ← t{int} * p{int}") do |int, int2, int3|
  (@p ||= {})[int] = @t[int2] * @p[int3]
end

Then("p{int} = point {float}, {float}, {float}") do |int, float, float2, float3|
  actual = @p[int]
  expect(actual).to be_point
  expect(actual.x).to be_within(0.00001).of(float)
  expect(actual.y).to be_within(0.00001).of(float2)
  expect(actual.z).to be_within(0.00001).of(float3)
end

When("transform ← t{int} * t{int} * t{int}") do |int, int2, int3|
  @transform = @t[int] * @t[int2] * @t[int3]
end
