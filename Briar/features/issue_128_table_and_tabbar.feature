@issue_128
Feature: issue 128 - should be able to touch rows that are partially hidden by tab bar
  touching a table row that is partially hidden by the tab bar touches the tab bar instead

  https://github.com/calabash/calabash-ios/issues/128
  https://groups.google.com/d/msg/calabash-ios/L6OmNnbhPW0/0fzLX-DJl-UJ

  @failing
  Scenario: if the last row of a table is partially hidden by the tab bar i should be able to touch the row and not the tab bar
    When I touch the "Tables" tab I should see the "tables" view

  # expected
    When I touch the "b" row I should see the "b alert"
    Then I dismiss the letter alert

  # found
  #  demonstrated the problem
  #  the tab button Text is touched and not the j row
    When I touch the last row I should see the i or j alert
