Feature: Material

  Scenario: The default material
    Given m ← material
    Then m.color = color 1, 1, 1
    And m.ambient = 0.1
    And m.diffuse = 0.9
    And m.specular = 0.9
    And m.shininess = 200.0
