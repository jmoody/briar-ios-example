@issue_128
@issues
Feature: issue 128 - should be able to touch rows that are partially hidden by tab bar
  touching a table row that is partially hidden by the tab bar touches the tab bar instead

  https://github.com/calabash/calabash-ios/issues/128
  https://groups.google.com/d/msg/calabash-ios/L6OmNnbhPW0/0fzLX-DJl-UJ

  Background:  should be able to navigate to the tables view
    When I touch the "Tables" tab I should see the "tables" view

  Scenario: if the last visible row of a table is partially hidden by the tab bar i should be able to touch the row and not the tab bar

  # expected
    When I touch the "b" row I should see the "b alert"
    Then I dismiss the letter alert

  # found
  #  demonstrates the problem tab bar problem
  #  the tab button Text is touched and not the j row
    When I touch the last row I should see the i or j alert

  Scenario: if the first visible row of a table is partially hidden by the nav bar i should be to touch the row and not the nav bar
    #expected
    When I touch the "c" row I should see the "c alert"
    Then I dismiss the letter alert

   #found
   #  demonstrates the nav bar problem
    Then I scroll down until the i row is partially hidden by the nav bar
    When I touch the first row I should see the i alert

