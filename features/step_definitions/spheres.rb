require 'sphere'

Given("s ← sphere") do
  @s = Sphere.new
end

When("xs ← intersect s, r") do
  @xs = @s.intersect(@r)
end

Then("xs.count = {int}") do |int|
  expect(@xs.count).to eq(int)
end

Then("xs[{int}].t = {float}") do |int, float|
  expect(@xs[int].t).to eq(float)
end

Then("xs[{int}].object = s") do |int|
  expect(@xs[int].object).to be(@s)
end