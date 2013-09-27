@first_view
Feature:  the first view

  Background: get me to the first view
    When I touch the "First" tab I should see the "first" view

  Scenario: show sheet button
    When I touch the "show sheet" button I should see an action sheet
    Then I dismiss the sheet with the cancel button

  Scenario: show alert button
    When I touch the "show alert" button I should see an alert
    Then I dismiss the alert with the cancel button

  Scenario: show email compose
    When I touch the "show email" button I should see an email compose view
    Then I dismiss the email view with the cancel button

