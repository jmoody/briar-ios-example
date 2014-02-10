@issue_309
@keyboard
Feature:  touching the keyboard action key AKA 'Return' AKA done
  In order not break keyboard interaction
  As a calabash framework tester
  I want a way to ensure I can touch the keyboard action key

  Background: get me to the text related view
    Given I am looking at the Text tab
    Given I choose a text input view at random
    And that text input view has the default keyboard

  Scenario: i want to touch the return key on the text input view
    Then I should be able to touch the Return key