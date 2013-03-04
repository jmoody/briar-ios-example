Feature: tabbar features
  test the tab bar features

  Scenario: i want to test the tabbar
    Then the tabbar is visible
    Then I touch the "Second" tab
    Then I should see "Second View"
    When I touch the "First" tab I should see the "First View" view

