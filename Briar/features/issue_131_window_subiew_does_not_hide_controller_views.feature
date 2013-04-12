@issues
@issue_131
Feature:  subviews of the main window should mask the views on the topmost controller
  #https://github.com/calabash/calabash-ios/issues/131

  Background:  a subview on the main window that hides the topmost controller completely
    When I add a security veil to the main window


  Scenario: the navbar is hidden but query can still find it
    Then I should not be able to see navigation bar because of the security veil
    Then I dismiss the security veil

  Scenario: the tabbar is hidden but query can still find it
    Then I should not be able to see tab bar because of the security veil
    Then I dismiss the security veil

  Scenario: the topmost view is hidden but query can still find the buttons
    Then I should not be able to see the elements on the topmost view
    Then I dismiss the security veil

