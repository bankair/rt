Feature: Sphere

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
