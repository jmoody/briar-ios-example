@issue_284
@keyboard
Feature: escaping backslash
  In order to write steps in a natural way
  As a calabash-ios gem tester
  I want to be able to naturally enter the backslash character
  https://github.com/calabash/calabash-ios/issues/284

  Background: get me to the text related view
    Given I am looking at the Text tab
    Given I choose a text input view at random
    And that text input view has the default keyboard

  Scenario: one backslash
    When I type a the following string with a backslash "This string \ has a backslash"
    Then I should see the correct string in that text field

  Scenario: two backslashes
    When I type a the following string with a backslash "This string \ has two \ backslashes"
    Then I should see the correct string in that text field

  Scenario: several backslashes
    When I type a the following string with a backslash "This \ string \ has \ several \ backslashes"
    Then I should see the correct string in that text field

  Scenario: backslash at the start
    When I type a the following string with a backslash "\This string starts \ with a \ backslash"
    Then I should see the correct string in that text field

  Scenario: backslash at the end
    When I type a the following string with a backslash "This \ string ends with a \ backslash\"
    Then I should see the correct string in that text field

  Scenario: backslashes at the beginning and end
    When I type a the following string with a backslash "\This \ string \ starts and ends \ with a \ backslash\"
    Then I should see the correct string in that text field

  Scenario: doubled backslash
    When I type a the following string with a backslash "This \\ string has a double backslash"
    Then I should see the correct string in that text field

  Scenario: triple backslash
    When I type a the following string with a backslash "This \\\ string has a triple backslash"
    Then I should see the correct string in that text field

  Scenario: wacky backslashes
    When I type a the following string with a backslash "\\This \\\\ string \\\\\ has \ wacky \ \ backslashes\\\"
    Then I should see the correct string in that text field