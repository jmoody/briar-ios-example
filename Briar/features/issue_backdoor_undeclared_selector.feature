Feature: calabash server should not crash the app if an undeclared selector is called through the backdoor

  Scenario: i should be able to call backdoor on a selector that exists and get the correct responds
    Then I ask the application if the device is configured to send email

  @failing
  Scenario: i should be able to call backdoor on a selector that does not exist and get failure response
    Then I ask the application if the device is configured scan for lifeforms
