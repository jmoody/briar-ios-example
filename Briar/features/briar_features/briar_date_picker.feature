@date_picker
Feature: briar date picker steps

  # todo
  #Then /^I change the minute interval on the picker to (1|5|10|30) minutes?$/ do |target_interval|

  Background: get me the the date picker tab
    When I touch the "Date" tab I should see the "date related" view

  # outlines are NYI on XTC
  @not_xtc
  Scenario Outline: touching a button should show the correct date picker
    When I touch the "Date" tab I should see the "date related" view
    Then I touch the "<button_id>" button and wait for the "<view_id>" view
    Then I should not see any of the show picker buttons
    Then I should see that the date picker is in <mode> mode
  Examples:
    | button_id                 | view_id              | mode          |
    | show time picker          | time picker          | time          |
    | show date picker          | date picker          | date          |
    | show date and time picker | date and time picker | date and time |

  Scenario: i should be able to change the date on the picker and see the label change
    Then I touch the "show time picker" button and wait for the "time picker" view
    When I change the time on the picker to "10:45", I should see the "time" label has the correct time
    When I change the time on the picker to "12:45 AM", I should see the "time" label has the correct time
    Then I change the time on the picker to "19:35", I should see the "time" label has the correct time
    Then I change the time on the picker to "1:35", I should see the "time" label has the correct time
    Then I change the time on the picker to "6:45 PM", I should see the "time" label has the correct time
    Then I change the time on the picker to "6:45 AM", I should see the "time" label has the correct time

  Scenario: i should be able to change the picker time by the minute
    Then I touch the "show time picker" button and wait for the "time picker" view
    Then I change the time on the picker to 20 minutes from now
    Then I change the time on the picker to 13 minutes before now
