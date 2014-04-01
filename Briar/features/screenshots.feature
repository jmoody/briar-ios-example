@screenshot
Feature: taking screenshots
  In order to provide superior screens
  As a calabash gem maintainer tester
  I want a faster screenshot

  Scenario: then i take a screenshot
    Then I take a screenshot and embedded it

  @wip
  Scenario: screenshot of mail compose view
    When I touch the "Buttons" tab I should see the "buttons" view
    Then I touch the show email button
    Then I take a screenshot and embedded it

