Feature: Sphere
  Scenario: A sphere is a shape
    Given s ← sphere
    Then s is a shape

  Scenario: A ray intersects a sphere at two points
    Given r ← ray point 0.0, 0.0, -5.0, vector 0.0, 0.0, 1.0
    And s ← sphere
    When xs ← intersect s, r
    Then xs.count = 2
    And xs[0].t = 4.0
    And xs[1].t = 6.0

  Scenario: A ray intersects a sphere at a tangent
    Given r ← ray point 0.0, 1.0, -5.0, vector 0.0, 0.0, 1.0
    And s ← sphere
    When xs ← intersect s, r
    Then xs.count = 2
    And xs[0].t = 5.0
    And xs[1].t = 5.0

  Scenario: A ray misses a sphere
    Given r ← ray point 0.0, 2.0, -5.0, vector 0.0, 0.0, 1.0
    And s ← sphere
    When xs ← intersect s, r
    Then xs.count = 0

  Scenario: A ray originates inside a sphere
    Given r ← ray point 0.0, 0.0, 0.0, vector 0.0, 0.0, 1.0
    And s ← sphere
    When xs ← intersect s, r
    Then xs.count = 2
    And xs[0].t = -1.0
    And xs[1].t = 1.0

  Scenario: A sphere is behind a ray
    Given r ← ray point 0.0, 0.0, 5.0, vector 0.0, 0.0, 1.0
    And s ← sphere
    When xs ← intersect s, r
    Then xs.count = 2
    And xs[0].t = -6.0
    And xs[1].t = -4.0

  Scenario: Intersect sets the object on the intersection
    Given r ← ray point 0.0, 0.0, -5.0, vector 0.0, 0.0, 1.0
    And s ← sphere
    When xs ← intersect s, r
    Then xs.count = 2
    And xs[0].object = s
    And xs[1].object = s

  Scenario: Intersecting a scaled sphere with a ray
    Given r ← ray point 0.0, 0.0, -5.0, vector 0.0, 0.0, 1.0
    And s ← sphere
    When set_transform s, scaling 2, 2, 2
    And xs ← intersect s, r
    Then xs.count = 2
    And xs[0].t = 3.0
    And xs[1].t = 7.0

  Scenario: Intersecting a translated sphere with a ray
    Given r ← ray point 0.0, 0.0, -5.0, vector 0.0, 0.0, 1.0
    And s ← sphere
    When set_transform s, translation 5, 0, 0
    And xs ← intersect s, r
    Then xs.count = 0

  Scenario: The normal on a sphere at a point on the x axis
    Given s ← sphere
    When n ← normal_at s, point 1.0, 0.0, 0.0
    Then n = vector 1.0, 0.0, 0.0

  Scenario: The normal on a sphere at a point on the y axis
    Given s ← sphere
    When n ← normal_at s, point 0.0, 1.0, 0.0
    Then n = vector 0.0, 1.0, 0.0

  Scenario: The normal on a sphere at a point on the z axis
    Given s ← sphere
    When n ← normal_at s, point 0.0, 0.0, 1.0
    Then n = vector 0.0, 0.0, 1.0

  Scenario: The normal on a sphere at a nonaxial point
    Given s ← sphere
    When n ← normal_at s, point 0.57735, 0.57735, 0.57735
    Then n = vector 0.57735, 0.57735, 0.57735

  Scenario: The normal is a normalized vector
    Given s ← sphere
    When n ← normal_at s, point 0.57735, 0.57735, 0.57735
    Then n = normalize n

  Scenario: Computing the normal on a translated sphere
    Given s ← sphere
    And set_transform s, translation 0.0, 1.0, 0.0
    When n ← normal_at s, point 0.0, 1.70711, -0.70711
    Then n = vector 0.0, 0.70711, -0.70711

  Scenario: Computing the normal on a transformed sphere
    Given s ← sphere
    And m ← scaling 1.0, 0.5, 1.0 * rotation_z π div 5
    And set_transform s, m
    When n ← normal_at s, point 0.0, 0.70711, -0.70711
    Then n = vector 0.0, 0.97014, -0.24254
