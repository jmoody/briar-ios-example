Feature: issue 132
  https://github.com/calabash/calabash-ios/issues/132
  FIXED

  # needs to fail to demonstrate the fix :(
  # this is a test on a calabash predefined step.  it was passing when it
  # should not have been passing
  Scenario: EXPECT TO FAIL i want to demonstrate that the issue is fixed
    When I touch the "Text" tab I should see the "text related" view
    Then I should not see a "placeholder!" text field


