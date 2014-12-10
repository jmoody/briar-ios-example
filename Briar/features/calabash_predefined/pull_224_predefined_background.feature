@launch
@pull_224
Feature: Send app to background

  Scenario: I should be able to background the app using the predefined steps
    Then I send app to background for 5 seconds
