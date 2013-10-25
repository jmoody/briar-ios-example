@date_picker
Feature: calabash date picker features


  Background: get me the the date picker tab
    When I touch the "Date" tab I should see the "date related" view

  # time string can be anything parseable by Time.parse
  Scenario: i should be able to use the predefined steps to change the picker time
    Then I touch the "show time picker" button and wait for the "time picker" view
    Then I change the date picker time to "10:45"
    Then I change the date picker time to "12:45 AM"
    Then I change the date picker time to "19:35"
    Then I change the date picker time to "1:35"
    Then I change the date picker time to "6:45 PM"
    Then I change the date picker time to "6:45 AM"

  # date string can be anything parseable by Date.parse
  Scenario: i should be able to use the predefined steps to change the picker date
    Then I touch the "show date picker" button and wait for the "date picker" view

      # not automatically parseable by Date
      #Then I change the date picker date to "05/13/2000"

      # not automatically parseable by Date
      #Then I change the date picker date to "05-13-2000"

      # incorrectly parsed by Date
      #Then I change the date picker date to "05 13 2000"

    Then I change the date picker date to "July 28 2009"
    Then I change the date picker date to "Dec 31 3029"
    Then I change the date picker date to "1980-09-14"

        # appears as Dec 31 2029
    Then I change the date picker date to "Dec 31 29"

      # unexpected
      # NSDateFormatter parses this date to 'Fri Nov 2' - weirdness
    Then I change the date picker date to "1492.11.11"

  Scenario: i should be able to use the predefined steps to change the picker date and time
    Then I touch the "show date and time picker" button and wait for the "date and time picker" view
    Then I change the date picker date to "July 28" at "15:23"
    Then I change the date picker date to "28 Aug" at "12:23 AM"
    Then I change the date picker date to "2013-03-14" at "12:23"
