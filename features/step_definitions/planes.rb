require 'plane'

Given("p ← plane") do
  @p = Plane.new
end

When("n{int} ← local_normal_at p, point {int}, {int}, {int}") do |int, int2, int3, int4|
  (@n ||= {})[int] = @p.local_normal_at(Tuple.point(int2, int3, int4))
end

Then("n{int} = vector {int}, {int}, {int}") do |int, int2, int3, int4|
  expect(@n[int]).to eq(Tuple.vector(int2, int3, int4))
end

When("xs ← local_intersect p, r") do
  @xs = @p.local_intersect(@r)
end

Then("xs is empty") do
  expect(@xs).to be_empty
end

Then("xs[{int}].object = p") do |int|
  expect(@xs[int].object).to eq(@p)
end
