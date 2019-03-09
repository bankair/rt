Feature: Tranformations

  Scenario: Multiplying by a translation matrix
    Given transform ← translation 5, -3, 2
    And p ← point -3, 4, 5
    Then transform * p = point 2, 1, 7

  Scenario: Multiplying by the inverse of a translation matrix
    Given transform ← translation 5, -3, 2
    And inv ← inverse transform
    And p ← point -3, 4, 5
    Then inv * p = point -8, 7, 3

  Scenario: Translation does not affect vectors
    Given transform ← translation 5, -3, 2
    And v ← vector -3, 4, 5
    Then transform * v = v

  Scenario: A scaling matrix applied to a point
    Given transform ← scaling 2, 3, 4
    And p ← point -4, 6, 8
    Then transform * p = point -8, 18, 32

  Scenario: A scaling matrix applied to a vector
    Given transform ← scaling 2, 3, 4
    And v ← vector -4, 6, 8
    Then transform * v = vector -8, 18, 32

  Scenario: Multiplying by the inverse of a scaling matrix
    Given transform ← scaling 2, 3, 4
    And inv ← inverse transform
    And v ← vector -4, 6, 8
    Then inv * v = vector -2, 2, 2

  Scenario: Reflection is scaling by a negative value
    Given transform ← scaling -1, 1, 1
    And p ← point 2, 3, 4
    Then transform * p = point -2, 3, 4

  Scenario: Rotating a point half a quarter around the x axis
    Given p ← point 0, 1, 0
    And transform ← rotation_x π div 4
    Then transform * p = point 0.0, 0.7071, 0.7071

  Scenario: Rotating a point a full quarter around the x axis
    Given p ← point 0, 1, 0
    And transform ← rotation_x π div 2
    Then transform * p = point 0.0, 0.0, 1.0

  Scenario: The inverse of an x-rotation rotates in the opposite direction
    Given p ← point 0, 1, 0
    And transform ← rotation_x π div 4
    And inv ← inverse transform
    Then inv * p = point 0.0, 0.7071, -0.7071

  Scenario: Rotating a point half a quarter around the y axis
    Given p ← point 0, 0, 1
    And transform ← rotation_y π div 4
    Then transform * p = point 0.7071, 0.0, 0.7071

  Scenario: Rotating a point a full quarter around the y axis
    Given p ← point 0, 0, 1
    And transform ← rotation_y π div 2
    Then transform * p = point 1.0, 0.0, 0.0

  Scenario: Rotating a point half a quarter around the z axis
    Given p ← point 0, 1, 0
    And transform ← rotation_z π div 4
    Then transform * p = point -0.7071, 0.7071, 0.0

  Scenario: Rotating a point a full quarter around the z axis
    Given p ← point 0, 1, 0
    And transform ← rotation_z π div 2
    Then transform * p = point -1.0, 0.0, 0.0

  Scenario: A shearing transformation moves x in proportion to y
    Given transform ← shearing 1, 0, 0, 0, 0, 0
    And p ← point 2, 3, 4
    Then transform * p = point 5, 3, 4

  Scenario: A shearing transformation moves x in proportion to z
    Given transform ← shearing 0, 1, 0, 0, 0, 0
    And p ← point 2, 3, 4
    Then transform * p = point 6, 3, 4

  Scenario: A shearing transformation moves y in proportion to x
    Given transform ← shearing 0, 0, 1, 0, 0, 0
    And p ← point 2, 3, 4
    Then transform * p = point 2, 5, 4

  Scenario: A shearing transformation moves y in proportion to z
    Given transform ← shearing 0, 0, 0, 1, 0, 0
    And p ← point 2, 3, 4
    Then transform * p = point 2, 7, 4

  Scenario: A shearing transformation moves z in proportion to x
    Given transform ← shearing 0, 0, 0, 0, 1, 0
    And p ← point 2, 3, 4
    Then transform * p = point 2, 3, 6

  Scenario: A shearing transformation moves z in proportion to y
    Given transform ← shearing 0, 0, 0, 0, 0, 1
    And p ← point 2, 3, 4
    Then transform * p = point 2, 3, 7

  Scenario: Individual transformations are applied in sequence
    Given p1 ← point 1, 0, 1
    And t1 ← rotation_x π div 2
    And t2 ← scaling 5, 5, 5
    And t3 ← translation 10, 5, 7
    # apply rotation first
    When p2 ← t1 * p1
    Then p2 = point 1.0, -1.0, 0.0
    # then apply scaling
    When p3 ← t2 * p2
    Then p3 = point 5.0, -5.0, 0.0
    # then apply translation
    When p4 ← t3 * p3
    Then p4 = point 15.0, 0.0, 7.0

  Scenario: Chained transformations must be applied in reverse order
    Given p ← point 1, 0, 1
    And t1 ← rotation_x π div 2
    And t2 ← scaling 5, 5, 5
    And t3 ← translation 10, 5, 7
    When transform ← t3 * t2 * t1
    Then transform * p = point 15, 0, 7
