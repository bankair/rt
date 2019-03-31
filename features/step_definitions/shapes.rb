Given("s ← test_shape") do
  @s = Shape.new
end

Then("s.transform = translation {int}, {int}, {int}") do |int, int2, int3|
  expect(@s.transform).to eq(Transformation.translation(int, int2, int3))
end
