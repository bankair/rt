require 'rtmatrix' # using ruby's matrices

Given("the following {int}x{int} matrix m:") do |int, int2, table|
  @m = RTMatrix[*table.raw.each { |row| row.map!(&:to_f) }]
end

Given("the following matrix m{int}:") do |int, table|
  (@m ||= {})[int] = RTMatrix[*table.raw.each { |row| row.map!(&:to_f) }]
end

Then("m1 = m2") do
  expect(@m[1]).to eq(@m[2])
end

Then("m1 != m2") do
  expect(@m[1]).to_not eq(@m[2])
end

Then("m[{int},{int}] = {int}") do |int, int2, int3|
  expect(@m[int, int2]).to eq(int3)
end

Then("m[{int},{int}] = {float}") do |int, int2, float|
  expect(@m[int, int2]).to eq(float)
end

Then("m{int} * m{int} is the following {int}x{int} matrix:") do |int, int2, int3, int4, table|
  result = RTMatrix[*table.raw.each { |row| row.map!(&:to_f) }]
  expect(@m[int] * @m[int2]).to eq(result)
end

Given("t ← tuple {float}, {float}, {float}, {float}") do |float, float2, float3, float4|
  @t = Tuple.new(float, float2, float3, float4)
end

Then("m{int} * t = tuple {int}, {int}, {int}, {int}") do |int, int2, int3, int4, int5|
  result = Tuple.new(int2, int3, int4, int5)
  expect(@m[int] * @t).to eq(result)
end

Then("m{int} * identity_matrix = m{int}") do |int, int2|
  expect(@m[int] * RTMatrix.identity(@m[int].row_count)).to eq(@m[int])
end

Then("identity_matrix * t = t") do
  expect(RTMatrix.identity(4) * @t).to eq(@t)
end

Then("transpose m{int} is the following matrix:") do |int, table|
  expected = RTMatrix[*table.raw.each { |row| row.map!(&:to_f) }]
  expect(@m[int].transpose).to eq(expected)
end

Given("A ← identity_matrix {int}") do |int|
  @a = RTMatrix.identity(int)
end

Then("transpose A = identity_matrix {int}") do |int|
  expect(@a.transpose).to eq(RTMatrix.identity(int))
end

Then("determinant m{int} = {int}") do |int, int2|
  expect(@m[int].determinant).to eq(int2)
end

Then("submatrix m{int}, {int}, {int} is the following {int}x{int} matrix:") do |int, int2, int3, int4, int5, table|
  expected = RTMatrix[*table.raw.each { |row| row.map!(&:to_f) }]
  expect(@m[int].submatrix(int2, int3)).to eq(expected)
end

Given("m{int} ← submatrix m{int}, {int}, {int}") do |int, int2, int3, int4|
  @m[int] = @m[int2].submatrix(int3, int4)
end

Then("minor m{int}, {int}, {int} = {int}") do |int, int2, int3, int4|
  expect(RTMatrix.minor(@m[int], int2, int3)).to eq(int4)
end

Then("cofactor m{int}, {int}, {int} = {int}") do |int, int2, int3, int4|
  expect(@m[int].cofactor(int2, int3)).to eq(int4)
end

Then("m{int} is invertible") do |int|
  expect(@m[int]).to be_invertible
end

Then("m{int} is not invertible") do |int|
  expect(@m[int]).to_not be_invertible
end

Given("m{int} ← inverse m{int}") do |int, int2|
  @m[int] = @m[int2].inverse
end

Then("m{int}[{int},{int}] = {int} div {int}") do |int, int2, int3, int4, int5|
  # expect(@m[int][int2, int3]).to eq(int4.to_f / int5)
end

Then("m{int} is the following matrix:") do |int, table|
  table.raw.each_with_index do |row, x|
    row.each_with_index do |expected_value, y|
      expect(@m[int][x, y]).to be_within(0.0001).of(expected_value.to_f)
    end
  end
end

Then("inverse m{int} is the following matrix:") do |int, table|
  inverse = @m[int].inverse
  table.raw.each_with_index do |row, x|
    row.each_with_index do |expected_value, y|
      expect(inverse[x, y]).to be_within(0.0001).of(expected_value.to_f)
    end
  end
end

Then("m{int} * m{int} * inverse m{int} = m{int}") do |int, int2, int3, int4|
  actual_matrix = (@m[int] * @m[int2]) * @m[int3].inverse
  expected = @m[int4]
  actual_matrix.each_with_index do |actual, x, y|
    expect(actual).to be_within(0.00001).of(expected[x, y])
  end
end
