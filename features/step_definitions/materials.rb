require 'material'

Given("m ← material") do
  @m = Material.new
end

Then("m.color = color {int}, {int}, {int}") do |int, int2, int3|
  expect(@m.color).to eq(Color.new(int, int2, int3))
end

Then("m.ambient = {float}") do |float|
  expect(@m.ambient).to eq(float)
end

Then("m.diffuse = {float}") do |float|
  expect(@m.diffuse).to eq(float)
end

Then("m.specular = {float}") do |float|
  expect(@m.specular).to eq(float)
end

Then("m.shininess = {float}") do |float|
  expect(@m.shininess).to eq(float)
end
