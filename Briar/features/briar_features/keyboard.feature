@keyboard
@delete_key
Feature: Interacting with the keyboard

  Background: Navigate to the text related views and default keyboard layouts
    Given I am looking at the Text tab
    And all the text input view have the default keyboard

  Scenario: Touching the delete key.
    Then I touch "top tf"
    Then I should be able to dock the keyboard
    Then I should see a "done text editing" button in the navbar
    Then I use the keyboard to enter "abc"
    Then I touch the delete key
    Then I should see "top tf" text field with text "ab"
    Then I am done text editing
    Then I should not see a "done text editing" button in the navbar
    Then I should not see the keyboard
