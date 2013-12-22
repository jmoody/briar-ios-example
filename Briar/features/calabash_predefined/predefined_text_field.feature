@text_field
@issue_151
Feature: testing the text field set_text, clear_text, and predefined steps
  In order to manipulate the text in text fields
  As a tester
  I want to be able to set the text, clear the text, enter text with the keyboard

  Background: get me to the text related tab
    Given I touch the "Text" tab I should see the "text related" view
    And I touch the "top" text field
    And I should be able to dock the keyboard

  Scenario: i should be able use the predefined text field steps
    # predefined
    Then I enter "this is great!" into the "top tf" field
    Then I should see "top tf" text field with text "this is great!"
    # predefined
    Then I clear input field number 1
    Then I should see "top tf" text field with text ""

    # predefined
    Then I enter "fantastic?" into the "top tf" input field
    Then I should see "top tf" text field with text "fantastic?"
    When I clear "top tf"
    Then I should see "top tf" text field with text ""

    # predefined
    Then I fill in "top tf" with "w00t!"
    Then I should see "top tf" text field with text "w00t!"
    Then I clear input field number 1
    Then I should see "top tf" text field with text ""

    # predefined
#    Then I use the native keyboard to enter "n8tive 0-||=| board" into the "top tf" text field
#    Then I should see "top tf" text field with text "n8tive 0-||=| board"
#    Then I clear input field number 1
#    Then I should see "top tf" text field with text ""

    Then I use the native keyboard to enter "n8t1ve k3y b0ard" into the "top tf" text field
    Then I should see "top tf" text field with text "n8t1ve k3y b0ard"
    Then I clear input field number 1
    Then I should see "top tf" text field with text ""


    Then I enter "put me in bottom text field" into text field number 2
    Then I should see "bottom tf" text field with text "put me in bottom text field"
    Then I clear input field number 2
    Then I should see "bottom tf" text field with text ""

    Then I use the native keyboard to enter "put me into the top" into input field number 1
    Then I should see "top tf" text field with text "put me into the top"
    Then I clear input field number 1
    Then I should see "top tf" text field with text ""

  Scenario: i should be able to fill in text fields with a table
    Then I fill in text fields as follows:
      | text               | field     |
      | into the top       | top tf    |
      | into the bottom    | bottom tf |
    Then I should see "top tf" text field with text "into the top"
    Then I should see "bottom tf" text field with text "into the bottom"
