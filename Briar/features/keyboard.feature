@keyboard
Feature: briar keyboard features

  Background: get us to the text related views so we can test the test the keyboard
    When I touch the "Text" tab I should see the "text related" view

  Scenario: i want to be able to touch the delete key
    # unexpected - issue 116
    # Then I touch the "input" text field
    Then I touch "top tf"
    Then I should see a "done text editing" button in the navbar
    Then I turn off spell checking and capitalization
    Then I use the keyboard to enter "abc"
    Then I touch the delete key
    Then I should see "top tf" text field with text "ab"
    Then I am done text editing
    Then I should not see a "done text editing" button in the navbar
    Then I should not see the keyboard


