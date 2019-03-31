Feature: Shape

  Scenario: The default transformation
    Given s ← test_shape
    Then s.transform = identity_matrix

  Scenario: Assigning a transformation
    Given s ← test_shape
    When set_transform s, translation 2, 3, 4
    Then s.transform = translation 2, 3, 4

  Scenario: The default material
    Given s ← test_shape
    When m ← s.material
    Then m = material

  Scenario: Assigning a material
    Given s ← test_shape
    And m ← material
    And m.ambient ← 1
    When s.material ← m
    Then s.material = m

  Scenario: Intersecting a scaled shape with a ray
    Given r ← ray point 0, 0, -5, vector 0, 0, 1
    And s ← test_shape
    When set_transform s, scaling 2, 2, 2
    And xs ← intersect s, r
    Then s.saved_ray.origin = point 0.0, 0.0, -2.5
    And s.saved_ray.direction = vector 0.0, 0.0, 0.5

  Scenario: Intersecting a translated shape with a ray
    Given r ← ray point 0, 0, -5, vector 0, 0, 1
    And s ← test_shape
    When set_transform s, translation 5, 0, 0
    And xs ← intersect s, r
    Then s.saved_ray.origin = point -5.0, 0.0, -5.0
    And s.saved_ray.direction = vector 0.0, 0.0, 1.0
