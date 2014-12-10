@issue_637
@keyboard
Feature: Can type strings with embedded newlines
  In order not break keyboard interaction
  As a calabash framework tester
  I want a way to ensure I can type newlines

  Background: Get me to the text related view
    Given I am looking at the Text tab
    And I choose a text view at random
    And that text input view has the default keyboard

  Scenario:  Typing strings with newlines
    Then I type a string with a newline
