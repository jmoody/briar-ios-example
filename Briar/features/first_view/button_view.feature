@button
Feature:  Interacting with buttons

  Background: Get me to the button view
    When I touch the "Buttons" tab I should see the "buttons" view

  Scenario: Show sheet button
    When I touch the "show sheet" button I should see an action sheet
    Then I dismiss the action sheet with the cancel button

  Scenario: Show alert button
    When I touch the "show alert" button I should see an alert
    Then I dismiss the alert with the cancel button

  Scenario: Show email compose
    When I touch the "show email" button I should see an email compose view
    Then I dismiss the email compose view with the cancel button
