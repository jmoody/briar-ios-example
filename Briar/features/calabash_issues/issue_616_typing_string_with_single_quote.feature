@issue_616
Feature: Type strings with single quotes
  In order to automate typing on a keyboard
  As a calabash user
  I want to be able to type contractions

  Scenario:  Typing a string with a single quote
    When I touch the Text tab, I should see the Text related part of the app
    And I type a contraction in the top text field
    Then I should see the contraction has been typed correctly
