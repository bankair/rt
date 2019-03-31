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
