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

Then("stripe_at pattern, point {float}, {float}, {float} = white") do |float, float2, float3|
  expect(@pattern.stripe_at(Tuple.point(float, float2, float3))).to eq(@white)
end

Then("stripe_at pattern, point {float}, {float}, {float} = black") do |float, float2, float3|
  expect(@pattern.stripe_at(Tuple.point(float, float2, float3))).to eq(@black)
end

Given("object ← sphere") do
  @object = Sphere.new
end

Given("set_transform object, scaling {float}, {float}, {float}") do |float, float2, float3|
  @object.transform = Transformation.scaling(float, float2, float3)
end

When("c ← stripe_at_object pattern, object, point {float}, {float}, {float}") do |float, float2, float3|
  @c = @pattern.stripe_at_object(@object, Tuple.point(float, float2, float3))
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

