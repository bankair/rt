Feature: Pattern

  Background:
    Given black ← color 0, 0, 0
    And white ← color 1, 1, 1

  Scenario: Creating a stripe pattern
    Given pattern ← stripe_pattern white, black
    Then pattern.a = white
    And pattern.b = black

  Scenario: A stripe pattern is constant in y
    Given pattern ← stripe_pattern white, black
    Then stripe_at pattern, point 0.0, 0.0, 0.0 = white
    And stripe_at pattern, point 0.0, 1.0, 0.0 = white
    And stripe_at pattern, point 0.0, 2.0, 0.0 = white

  Scenario: A stripe pattern is constant in z
    Given pattern ← stripe_pattern white, black
    Then stripe_at pattern, point 0.0, 0.0, 0.0 = white
    And stripe_at pattern, point 0.0, 0.0, 1.0 = white
    And stripe_at pattern, point 0.0, 0.0, 2.0 = white

  Scenario: A stripe pattern alternates in x
    Given pattern ← stripe_pattern white, black
    Then stripe_at pattern, point 0.0, 0.0, 0.0 = white
    And stripe_at pattern, point 0.9, 0.0, 0.0 = white
    And stripe_at pattern, point 1.0, 0.0, 0.0 = black
    And stripe_at pattern, point -0.1, 0.0, 0.0 = black
    And stripe_at pattern, point -1.0, 0.0, 0.0 = black
    And stripe_at pattern, point -1.1, 0.0, 0.0 = white

  Scenario: Stripes with an object transformation
    Given object ← sphere
    And set_transform object, scaling 2.0, 2.0, 2.0
    And pattern ← stripe_pattern white, black
    When c ← stripe_at_object pattern, object, point 1.5, 0.0, 0.0
    Then c = white

  Scenario: Stripes with a pattern transformation
    Given object ← sphere
    And pattern ← stripe_pattern white, black
    And set_pattern_transform pattern, scaling 2.0, 2.0, 2.0
    When c ← stripe_at_object pattern, object, point 1.5, 0.0, 0.0
    Then c = white

  Scenario: Stripes with both an object and a pattern transformation
    Given object ← sphere
    And set_transform object, scaling 2.0, 2.0, 2.0
    And pattern ← stripe_pattern white, black
    And set_pattern_transform pattern, translation 0.5, 0.0, 0.0
    When c ← stripe_at_object pattern, object, point 2.5, 0.0, 0.0
    Then c = white
