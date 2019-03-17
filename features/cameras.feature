Feature: Camera

  Scenario: Constructing a camera
    Given hsize ← 160
    And vsize ← 120
    And field_of_view ← π div 2
    When c ← camera hsize, vsize, field_of_view
    Then c.hsize = 160
    And c.vsize = 120
    And c.field_of_view = π div 2
    And c.transform = identity_matrix

  Scenario: The pixel size for a horizontal canvas
    Given c ← camera 200, 125, π div 2
    Then c.pixel_size = 0.01

  Scenario: The pixel size for a vertical canvas
    Given c ← camera 125, 200, π div 2
    Then c.pixel_size = 0.01

  Scenario: Constructing a ray through the center of the canvas
    Given c ← camera 201, 101, π div 2
    When r ← ray_for_pixel c, 100, 50
    Then r.origin = point 0, 0, 0
    And r.direction = vector 0, 0, -1

  Scenario: Constructing a ray through a corner of the canvas
    Given c ← camera 201, 101, π div 2
    When r ← ray_for_pixel c, 0, 0
    Then r.origin = point 0, 0, 0
    And r.direction = vector 0.66519, 0.33259, -0.66851

  Scenario: Constructing a ray when the camera is transformed
    Given c ← camera 201, 101, π div 2
    When c.transform ← rotation_y π div 4 * translation 0, -2, 5
    And r ← ray_for_pixel c, 100, 50
    Then r.origin = point 0, 2, -5
    And r.direction = vector 0.70711, 0, -0.70711
