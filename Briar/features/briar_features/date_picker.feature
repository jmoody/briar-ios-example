@date_picker
Feature: briar date picker steps

  Background: get me the the date picker tab
    When I touch the "Date" tab I should see the "date related" view

  Scenario: i should be able to make the picker appear by touching the button
    Then I touch the "show picker" button and wait for the "wake up picker" view
    Then I should not see the "show picker" button

  Scenario: i should be able to change the date on the picker and see the label change
    Then I touch the "show picker" button and wait for the "wake up picker" view
    Then I should see that the date picker is in time mode
    Then I change the time on the picker to "10:45"
    Then I change the time on the picker to "12:45 AM"
    Then I change the time on the picker to "19:35"
    Then I change the time on the picker to "1:35"
    Then I change the time on the picker to "6:45 PM"
    Then I change the time on the picker to "6:45 AM"

    Then I change the time on the picker to 20 minutes from now
    Then I change the time on the picker to 13 minutes before now



#Then /^I change the minute interval on the picker to (1|5|10|30) minutes?$/ do |target_interval|




