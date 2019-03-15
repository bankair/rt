require 'camera'

Given("hsize ← {int}") do |int|
  @hsize = int
end

Given("vsize ← {int}") do |int|
  @vsize = int
end

Given("field_of_view ← π div {int}") do |int|
  @field_of_view = Math::PI / int
end

When("c ← camera hsize, vsize, field_of_view") do
  @c = Camera.new(@hsize, @vsize, @field_of_view)
end

Then("c.hsize = {int}") do |int|
  expect(@c.hsize).to eq(int)
end

Then("c.vsize = {int}") do |int|
  expect(@c.vsize).to eq(int)
end

Then("c.field_of_view = π div {int}") do |int|
  expect(@c.field_of_view).to eq(Math::PI / int)
end

Then("c.transform = identity_matrix") do
  expect(@c.transform).to eq(RTMatrix.identity(4))
end

Given("c ← camera {int}, {int}, π div {int}") do |int, int2, int3|
  @c = Camera.new(int, int2, Math::PI / int3)
end

Then("c.pixel_size = {float}") do |float|
  expect(@c.pixel_size).to be_within(0.00001).of(float)
end
