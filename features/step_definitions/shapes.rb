require 'shape'

class TestShape < Shape
  attr_accessor :saved_ray

  def local_intersect(ray)
    @saved_ray = ray
  end
end

Given("s ← test_shape") do
  @s = TestShape.new
end

Then("s.transform = translation {int}, {int}, {int}") do |int, int2, int3|
  expect(@s.transform).to eq(Transformation.translation(int, int2, int3))
end

Then("s.saved_ray.origin = point {float}, {float}, {float}") do |float, float2, float3|
  expect(@s.saved_ray.origin).to eq(Tuple.point(float, float2, float3))
end

Then("s.saved_ray.direction = vector {float}, {float}, {float}") do |float, float2, float3|
  expect(@s.saved_ray.direction).to eq(Tuple.vector(float, float2, float3))
end
