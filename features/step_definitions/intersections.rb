require 'intersection'

When("i ← intersection {float}, s") do |float|
  @i = Intersection.new(float, @s)
end

Then("i.t = {float}") do |float|
  expect(@i.t).to eq(float)
end

Then("i.object = s") do
  expect(@i.object).to be(@s)
end

Given("i{int} ← intersection {int}, s") do |int, int2|
  (@i ||= {})[int] = Intersection.new(int2, @s)
end

When("xs ← intersections i{int}, i{int}") do |int, int2|
  @xs = Intersection[@i[int], @i[int2]]
end

Then("xs[{int}].t = {int}") do |int, int2|
  expect(@xs[int].t).to eq(int2)
end

When("h ← hit xs") do
  @h = @xs.hit
end

Then("h = i{int}") do |int|
  expect(@h).to eq(@i[int])
end

Then("h is nothing") do
  expect(@h).to be_nil
end

Given("xs ← intersections i{int}, i{int}, i{int}, i{int}") do |int, int2, int3, int4|
  @xs = Intersection[@i[int], @i[int2], @i[int3], @i[int4]]
end

Given("shape ← sphere") do
  @shape = Sphere.new
end

Given("i ← intersection {int}, shape") do |int|
  @i = Intersection.new(int, @shape)
end

When("comps ← prepare_computations i, r") do
  @comps = @i.prepare_computations(@r)
end

Then("comps.t = i.t") do
  expect(@comps.t).to eq(@i.t)
end

Then("comps.object = i.object") do
  expect(@comps.object).to eq(@i.object)
end

Then("comps.point = point {int}, {int}, {int}") do |int, int2, int3|
  expect(@comps.point).to eq(Tuple.point(int, int2, int3))
end

Then("comps.eyev = vector {int}, {int}, {int}") do |int, int2, int3|
  expect(@comps.eyev).to eq(Tuple.vector(int, int2, int3))
end

Then("comps.normalv = vector {int}, {int}, {int}") do |int, int2, int3|
  expect(@comps.normalv).to eq(Tuple.vector(int, int2, int3))
end

Then("comps.inside = false") do
  expect(@comps.inside).to be(false)
end

Then("comps.inside = true") do
  expect(@comps.inside).to be(true)
end

Given("shape ← sphere  with:") do |table|
  @shape = build_sphere_from(table)
end

Then("comps.over_point.z < -EPSILON div {int}") do |int|
  expect(@comps.over_point.z < - epsilon / int).to be_truthy
end

Then("comps.point.z > comps.over_point.z") do
  expect(@comps.point.z > @comps.over_point.z).to be_truthy
end
