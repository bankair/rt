require 'pattern'

Given("black ← color {int}, {int}, {int}") do |int, int2, int3|
  @black = Color.new(int, int2, int3)
end

Given("white ← color {int}, {int}, {int}") do |int, int2, int3|
  @white = Color.new(int, int2, int3)
end

Given("pattern ← stripe_pattern white, black") do
  @pattern = Pattern::Stripe.new(@white, @black)
end

Then("pattern.a = white") do
  expect(@pattern.a).to eq(@white)
end

Then("pattern.b = black") do
  expect(@pattern.b).to eq(@black)
end

Then("pattern_at pattern, point {float}, {float}, {float} = white") do |float, float2, float3|
  expect(@pattern.pattern_at(Tuple.point(float, float2, float3))).to eq(@white)
end

Then("pattern_at pattern, point {float}, {float}, {float} = black") do |float, float2, float3|
  expect(@pattern.pattern_at(Tuple.point(float, float2, float3))).to eq(@black)
end

Given("object ← sphere") do
  @object = Sphere.new
end

Given("set_transform object, scaling {float}, {float}, {float}") do |float, float2, float3|
  @object.transform = Transformation.scaling(float, float2, float3)
end

When("c ← pattern_at_object pattern, object, point {float}, {float}, {float}") do |float, float2, float3|
  @c = @pattern.pattern_at_shape(@object, Tuple.point(float, float2, float3))
end

Then("c = white") do
  expect(@c).to eq(@white)
end

Given("set_pattern_transform pattern, scaling {float}, {float}, {float}") do |float, float2, float3|
  @pattern.transform = Transformation.scaling(float, float2, float3)
end

Given("set_pattern_transform pattern, translation {float}, {float}, {float}") do |float, float2, float3|
  @pattern.transform = Transformation.translation(float, float2, float3)
end

class TestPattern < Pattern
  def pattern_at(point)
    Color.new(point.x, point.y, point.z)
  end

  quacks_like_a! Pattern::Specialization
end

Given("pattern ← test_pattern") do
  @pattern = TestPattern.new
end

Then("pattern.transform = identity_matrix") do
  expect(@pattern.transform).to eq(RTMatrix::IDENTITY)
end

Then("pattern.transform = translation {int}, {int}, {int}") do |int, int2, int3|
  expect(@pattern.transform).to eq(Transformation.translation(int, int2, int3))
end

Given("set_transform shape, scaling {float}, {float}, {float}") do |float, float2, float3|
  @shape.transform = Transformation.scaling(float, float2, float3)
end

When("c ← pattern_at_shape pattern, shape, point {float}, {float}, {float}") do |float, float2, float3|
  @c = @pattern.pattern_at_shape(@shape, Tuple.point(float, float2, float3))
end

Given("pattern ← gradient_pattern white, black") do
  @pattern = Pattern::Gradient.new(Color::WHITE, Color::BLACK)
end

Then("pattern_at pattern, point {int}, {int}, {int} = white") do |int, int2, int3|
  expect(@pattern.pattern_at(Tuple.point(int, int2, int3))).to eq(Color::WHITE)
end

Then("pattern_at pattern, point {float}, {float}, {float} = color {float}, {float}, {float}") do |float, float2, float3, float4, float5, float6|
  expect(@pattern.pattern_at(Tuple.point(float, float2, float3))).to eq(
    Color.new(float4, float5, float6)
  )
end

Given("pattern ← ring_pattern white, black") do
  @pattern = Pattern::Ring.new(Color::WHITE, Color::BLACK)
end

Given("pattern ← checkers_pattern white, black") do
  @pattern = Pattern::Checkers.new(Color::WHITE, Color::BLACK)
end
