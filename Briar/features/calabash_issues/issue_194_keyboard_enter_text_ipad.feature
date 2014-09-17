@issue_194
@ipad_only
@predefined_steps
Feature:  testing keyboard enter text on ipad

  Background: get me to the text related view and orient me down
    When I touch the Text tab, I should see the Text related part of the app

  # predefined steps
  # passes - was bug
  Scenario: i should be able use keyboard_enter_text to input all characters
    Then I use the native keyboard to enter "n8tive 0-||=| board" into the "top tf" text field
    Then I should see "top tf" text field with text "n8tive 0-||=| board"
