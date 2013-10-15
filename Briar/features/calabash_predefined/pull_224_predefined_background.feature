@launch
@pull_224
Feature:  the predefined background step

  Scenario: i should be able to background the app using the predefined steps
    Then I send app to background for 5 seconds
