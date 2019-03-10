Feature: Rays of light

  Scenario: Creating and querying a ray
    Given origin ← point 1, 2, 3
    And direction ← vector 4, 5, 6
    When r ← ray origin, direction
    Then r.origin = origin
    And r.direction = direction

  Scenario: Computing a point from a distance
    Given r ← ray point 2.0, 3.0, 4.0, vector 1.0, 0.0, 0.0
    Then position r, 0.0 = point 2.0, 3.0, 4.0
    And position r, 1.0 = point 3.0, 3.0, 4.0
    And position r, -1.0 = point 1.0, 3.0, 4.0
    And position r, 2.5 = point 4.5, 3.0, 4.0

  Scenario: Translating a ray
    Given r1 ← ray point 1, 2, 3, vector 0, 1, 0
    And m ← translation 3, 4, 5
    When r2 ← transform r1, m
    Then r2.origin = point 4, 6, 8
    And r2.direction = vector 0, 1, 0

  Scenario: Scaling a ray
    Given r1 ← ray point 1, 2, 3, vector 0, 1, 0
    And m ← scaling 2, 3, 4
    When r2 ← transform r1, m
    Then r2.origin = point 2, 6, 12
    And r2.direction = vector 0, 3, 0
