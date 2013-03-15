@bars
@tabbar
Feature: tabbar features
  test the tab bar features

  Background:  get the view in the right shape for tabbar testing
    Then I should see the tabbar

  Scenario: i want to test the briar tab bar visibility steps
    Then I touch the "show sheet" button and wait for the "sheet" view
    Then I should not see the tabbar
    Then I touch "Cancel"
    Then I should see the tabbar

  Scenario: i want to test the briar tab bar item touching
    When I touch the "Second" tab I should see the "Second View" view
    Then I touch the "First" tab
    Then I should see "first view"

  Scenario: i want to test the briar tab bar item visibility
    Then I should see tabbar button "First" at index 0
    Then I should see tabbar button "Second" at index 1

