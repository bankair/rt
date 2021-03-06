Feature: World

  Background: The default world
    Given w ← default_world
    And light ← point_light point -10, 10, -10, color 1, 1, 1
    And s1 ← sphere with:
      | material.color |  0.8, 1.0, 0.6 |
      | material.diffuse | 0.7 |
      | material.specular | 0.2 |
    And s2 ← sphere with:
      | transform | scaling 0.5, 0.5, 0.5 |
    When w.light = light
    And w contains s1
    And w contains s2

  Scenario: Creating a world
    Given w ← world
    Then w contains no objects
    And w has no light source

  Scenario: Intersect a world with a ray
    Given r ← ray point 0, 0, -5, vector 0, 0, 1
    When xs ← intersect_world w, r
    Then xs.count = 4
    And xs[0].t = 4.0
    And xs[1].t = 4.5
    And xs[2].t = 5.5
    And xs[3].t = 6.0

  Scenario: Shading an intersection
    Given r ← ray point 0, 0, -5, vector 0, 0, 1
    And shape ← the first object in w
    And i ← intersection 4, shape
    When comps ← prepare_computations i, r
    And c ← shade_hit w, comps
    Then c = color 0.38066, 0.47583, 0.2855

  Scenario: Shading an intersection from the inside
    Given w.light ← point_light point 0.0, 0.25, 0.0, color 1.0, 1.0, 1.0
    And r ← ray point 0, 0, 0, vector 0, 0, 1
    And shape ← the second object in w
    And i ← intersection 0.5, shape
    When comps ← prepare_computations i, r
    And c ← shade_hit w, comps
    Then c = color 0.90498, 0.90498, 0.90498

  Scenario: The color when a ray misses
    Given r ← ray point 0, 0, -5, vector 0, 1, 0
    When c ← color_at w, r
    Then c = color 0, 0, 0

  Scenario: The color when a ray hits
    Given r ← ray point 0, 0, -5, vector 0, 0, 1
    When c ← color_at w, r
    Then c = color 0.38066, 0.47583, 0.2855

  Scenario: The color with an intersection behind the ray
    Given outer ← the first object in w
    And outer.material.ambient ← 1
    And inner ← the second object in w
    And inner.material.ambient ← 1
    And r ← ray point 0.0, 0.0, 0.75, vector 0.0, 0.0, -1.0
    When c ← color_at w, r
    Then c = inner.material.color

  Scenario: There is no shadow when nothing is collinear with point and light
    Given p ← point 0, 10, 0
    Then is_shadowed w, p is false

  Scenario: The shadow when an object is between the point and the light
    Given p ← point 10, -10, 10
    Then is_shadowed w, p is true

  Scenario: There is no shadow when an object is behind the light
    Given p ← point -20, 20, -20
    Then is_shadowed w, p is false

  Scenario: There is no shadow when an object is behind the point
    Given p ← point -2, 2, -2
    Then is_shadowed w, p is false

  Scenario: shade_hit  is given an intersection in shadow
    Given w ← world
    And w.light ← point_light point 0, 0, -10, color 1, 1, 1
    And s1 ← sphere
    And s1 is added to w
    And s2 ← sphere with:
      | transform | translation 0, 0, 10 |
    And s2 is added to w
    And r ← ray point 0, 0, 5, vector 0, 0, 1
    And i ← intersection 4, s2
    When comps ← prepare_computations i, r
    And c ← shade_hit w, comps
    Then c = color 0.1, 0.1, 0.1

  Scenario: The reflected color for a nonreflective material
    Given r ← ray point 0.0, 0.0, 0.0, vector 0.0, 0.0, 1.0
    And shape ← the second object in w
    And shape.material.ambient ← 1.0
    And i ← intersection 1.0, shape
    When comps ← prepare_computations i, r
    And color ← reflected_color w, comps
    Then color = color 0.0, 0.0, 0.0

  Scenario: The reflected color for a reflective material
    Given shape ← plane with:
      | material.reflective | 0.5 |
      | transform | translation 0, -1, 0 |
    And shape is added to w
    And r ← ray point 0.0, 0.0, -3.0, vector 0.0, -0.70711, 0.70711
    And i ← intersection √2, shape
    When comps ← prepare_computations i, r
    And color ← reflected_color w, comps
    Then color = color 0.19032, 0.2379, 0.14274

  Scenario: shade_hit  with a reflective material
    Given shape ← plane with:
      | material.reflective | 0.5 |
      | transform | translation 0, -1, 0 |
    And shape is added to w
    And r ← ray point 0.0, 0.0, -3.0, vector 0.0, -0.70711, 0.70711
    And i ← intersection √2, shape
    When comps ← prepare_computations i, r
    And color ← shade_hit w, comps
    Then color = color 0.87677, 0.92436, 0.82918

  Scenario: color_at  with mutually reflective surfaces
    Given w ← world
    And w.light ← point_light point 0, 0, 0, color 1, 1, 1
    And lower ← plane  with:
      | material.reflective | 1 |
      | transform | translation 0, -1, 0 |
    And lower is added to w
    And upper ← plane  with:
      | material.reflective | 1 |
      | transform | translation 0, 1, 0 |
    And upper is added to w
    And r ← ray point 0, 0, 0, vector 0, 1, 0
    Then color_at w, r should terminate successfully

  Scenario: The reflected color at the maximum recursive depth
    Given w ← default_world
    And shape ← plane with:
      | material.reflective | 0.5 |
      | transform | translation 0, -1, 0 |
    And shape is added to w
    And r ← ray point 0.0, 0.0, -3.0, vector 0.0, -0.70711, 0.70711
    And i ← intersection √2, shape
    When comps ← prepare_computations i, r
    And color ← reflected_color w, comps, 0
    Then color = color 0.0, 0.0, 0.0
