@rotation
@alert
@sheet
@email
@buttons
Feature: i want to be able to rotate and touch things on iOS 7

  Background:  start on the buttons view
    When I touch the "Buttons" tab I should see the "buttons" view

  Scenario: Touch email button when home button is down
    Then I rotate the home button to the down position
    When I touch the "show email" button I should see an email compose view
    Then I dismiss the email compose view with the cancel button

  Scenario: Touch alert button when home button is down
    Then I rotate the home button to the down position
    When I touch the "show alert" button I should see an alert
    Then I dismiss the alert with the cancel button

  Scenario: Touch email button when home button is up
    Then I rotate the home button to the up position
    When I touch the "show email" button I should see an email compose view
    Then I dismiss the email compose view with the cancel button

  Scenario: Touch sheet button when home button is down
    Then I rotate the home button to the down position
    When I touch the "show sheet" button I should see an action sheet
    Then I dismiss the action sheet with the cancel button

  Scenario: Touch alert button when home button is left
    Then I rotate the home button to the left position
    When I touch the "show alert" button I should see an alert
    Then I dismiss the alert with the cancel button

  Scenario: Touch email button when home button is right
    Then I rotate the home button to the right position
    When I touch the "show email" button I should see an email compose view
    Then I dismiss the email compose view with the cancel button

  Scenario: Touch sheet button when home button is up
    Then I rotate the home button to the up position
    When I touch the "show sheet" button I should see an action sheet
    Then I dismiss the action sheet with the cancel button

  Scenario: Touch sheet button when home button is left
    Then I rotate the home button to the left position
    When I touch the "show sheet" button I should see an action sheet
    Then I dismiss the action sheet with the cancel button

  Scenario: Touch alert button when home button is up
    Then I rotate the home button to the up position
    When I touch the "show alert" button I should see an alert
    Then I dismiss the alert with the cancel button

  Scenario: Touch sheet button when home button is right
    Then I rotate the home button to the right position
    When I touch the "show sheet" button I should see an action sheet
    Then I dismiss the action sheet with the cancel button

  Scenario: Touch email button when home button is left
    Then I rotate the home button to the left position
    When I touch the "show email" button I should see an email compose view
    Then I dismiss the email compose view with the cancel button

  Scenario: Touch alert button when home button is right
    Then I rotate the home button to the right position
    When I touch the "show alert" button I should see an alert
    Then I dismiss the alert with the cancel button
