@issue_284
@keyboard
Feature: Escaping backslashes
  In order to write steps in a natural way
  As a calabash-ios gem tester
  I want to be able to naturally enter the backslash character
  https://github.com/calabash/calabash-ios/issues/284

  Background: Get me to the text related view
    Given I am looking at the Text tab
    Given I choose a text input view at random
    And that text input view has the default keyboard
    And I touch that text input view
    And the keyboard is showing
    And the keyboard is docked

  Scenario: Non-interpolated string with one backslash
    When I type a non-interpolated string with one backslash
    Then I should see the backslash has been correctly typed

  Scenario: Interpolated string with one backslash
    When I type an interpolated string with one backslash
    Then I see that the single backslash was escaped to a dot

  Scenario: Non-interpolated string with several backslashes
    When I type a non-interpolated string with several backslashes
    Then I should see the backslash has been correctly typed

  Scenario: Non-interpolated string with backslash at the start
    When I type a non-interpolated string that starts with a backslash
    Then I should see the backslash has been correctly typed

  Scenario: Non-interpolated string with backslash at the end
    When I type a non-interpolated string that ends with a backslash
    Then I should see the backslash has been correctly typed

  Scenario: Non-interpolated string with a double backslash
    When I type a non-interpolated string with a double backslash
    Then I should see that 1 backslash has been typed

  Scenario: Non-interpolated string with a triple backslash
    When I type a non-interpolated string with a triple backslash
    Then I should see that 2 backslash has been typed

  Scenario: Interpolated string with a double backslash
    When I type an interpolated string with a double backslash
    Then I should see that 1 backslash has been typed

  Scenario: Interpolated string with a triple backslash
    When I type an interpolated string with a triple backslash
    Then I should see that 1 backslash has been typed

  Scenario: Interpolated string with a quadruple backslash
    When I type an interpolated string with a quadruple backslash
    Then I should see that 2 backslash has been typed
