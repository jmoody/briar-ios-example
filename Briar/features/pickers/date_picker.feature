Feature: briar date picker steps

  Background: get me the the date picker tab
    When I touch the "Date" tab I should see the "date related" view

  Scenario: should be able to make the picker appear by touching the button
    Then I touch the "show picker" button and wait for the "wake up picker" view
