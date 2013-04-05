@bars
@tabbar
Feature: tabbar features
  test the tab bar features

  Scenario: i want to test the briar tab bar visibility steps
    Then I should see tabbar button "First" at index 0
    Then I should see tabbar button "Text" at index 1
    Then I should see tabbar button "Date" at index 2
    Then I should see "First, Text, Date" tabs
    When I touch the "Text" tab I should see the "text related" view
    When I touch the "First" tab I should see the "first" view
    Then I touch the "email" button and wait for the "compose email" view
    Then I should not see the tab bar



