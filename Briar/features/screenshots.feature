@screenshot
Feature: taking screenshots
  In order to provide superior screens
  As a calabash gem maintainer tester
  I want a faster screenshot

  Scenario: then i take a screenshot
    Then I take a screenshot and embedded it

  # email accounts are not available on the XTC
  @not_xtc
  Scenario: screenshot of mail compose view
    Given I see the Buttons tab
    Then I touch the show email button
    Then I take a screenshot and embedded it

  Scenario: screenshot of alert view
    Given I see the Buttons tab
    Then I touch the show alert button
    Then I take a screenshot and embedded it

  Scenario: screenshot of action sheet
    Given I see the Buttons tab
    Then I touch the show sheet button
    Then I take a screenshot and embedded it
