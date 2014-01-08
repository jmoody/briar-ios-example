@keyboard
@numeric_keyboard
@issue_256
@delete_key
Feature:  numeric keyboards
  In order to fully exercise my app
  As a BDD developer
  I want to be able to interact with iOS numeric keyboards

  Background:  get me to the text related view
    Given I am looking at the Text tab
    And the top text field has a number pad showing

  Scenario:  i want to see a numeric keyboard when i touch the top text field
    Then set my pin to "0123"
    When I tap the delete key 1 time, I should see "012" in the text field
