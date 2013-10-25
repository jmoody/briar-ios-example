@bars
@tabbar
Feature: tabbar features
  test the tab bar features

  Scenario: i want to test the briar tab bar visibility steps
    Then I should see tabbar button "Buttons" at index 0
    Then I should see tabbar button "Text" at index 1
    Then I should see tabbar button "Date" at index 2
    Then I should see tabbar button "Tables" at index 3
    Then I should see tabbar button "Sliders" at index 4
    Then I should see "Buttons, Text, Date, Tables, Sliders" tabs
    When I touch the "Text" tab I should see the "text related" view
    When I touch the "Buttons" tab I should see the "buttons" view


