@bars
@tabbar
Feature: tabbar features
  test the tab bar features

  Scenario: i want to test the briar tab bar visibility steps
    Then I should see tabbar button "First" at index 0
    Then I should see tabbar button "Text" at index 1
    Then I should see tabbar button "Date" at index 2
    Then I should see "First, Text, Date, Tables" tabs
    When I touch the "Text" tab I should see the "text related" view
    When I touch the "First" tab I should see the "first" view
    # todo add a view to the briar-ios-example that hides the tab bar
    When we are testing on the simulator or a device configured to send emails
    Then I touch the "email" button and wait for the "compose email" view
    Then I should not see the tab bar if I am on the iphone or if ipad is orientated left or right

