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

When("r ← ray_for_pixel c, {int}, {int}") do |int, int2|
  @r = @c.ray_for_pixel(int, int2)
end

Then("r.origin = point {int}, {int}, {int}") do |int, int2, int3|
  expect(@r.origin).to eq(Tuple.point(int, int2, int3))
end

Then("r.direction = vector {int}, {int}, {int}") do |int, int2, int3|
  expect(@r.direction).to be_vector
  expect(@r.direction.x).to be_within(0.0001).of(int)
  expect(@r.direction.y).to be_within(0.0001).of(int2)
  expect(@r.direction.z).to be_within(0.0001).of(int3)
end

Then("r.direction = vector {float}, {float}, {float}") do |float, float2, float3|
  expect(@r.direction).to be_vector
  expect(@r.direction.x).to be_within(0.0001).of(float)
  expect(@r.direction.y).to be_within(0.0001).of(float2)
  expect(@r.direction.z).to be_within(0.0001).of(float3)
end

When("c.transform ← rotation_y π div {int} * translation {int}, {int}, {int}") do |int, int2, int3, int4|
  @c.transform =
    Transformation.rotation_y(Math::PI / int) *
    Transformation.translation(int2, int3, int4)
end

Then("r.direction = vector {float}, {int}, {float}") do |float, int, float2|
  expect(@r.direction).to be_vector
  expect(@r.direction.x).to be_within(0.0001).of(float)
  expect(@r.direction.y).to be_within(0.0001).of(int)
  expect(@r.direction.z).to be_within(0.0001).of(float2)
end

Given("c.transform ← view_transform from, to, up") do
  @c.transform = Transformation.view_transform(@from, @to, @up)
end

When("image ← render c, w") do
  @image = @c.render(@w)
end

Then("pixel_at image, {int}, {int} = color {float}, {float}, {float}") do |int, int2, float, float2, float3|
  expect(@image[int, int2].red).to be_within(0.0001).of(float)
  expect(@image[int, int2].green).to be_within(0.0001).of(float2)
  expect(@image[int, int2].blue).to be_within(0.0001).of(float3)
end

Given("w.light ← light") do
  @w.light = @light
end
