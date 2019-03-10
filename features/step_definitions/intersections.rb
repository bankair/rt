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
