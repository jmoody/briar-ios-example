@rotation
@issue_156
Feature: Status bar and device orientation

  Scenario: After random rotations, status bar and device orientation should be the same
    Then I rotate the device 4 times in a random direction
    Then the orientation of the status bar and device should be same

  Scenario: Rotating home button to the left
    Then I rotate the device so the home button is on the left
    Then the orientation of the status bar and device should be same

  Scenario: Rotating home button to the right
    Then I rotate the device so the home button is on the right
    Then the orientation of the status bar and device should be same

  Scenario: Rotating home button to the top
    Then I rotate the device so the home button is on the top
    Then the orientation of the status bar and device should be same
