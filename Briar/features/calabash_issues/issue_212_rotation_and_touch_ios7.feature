@driis
@rotation
Feature: i want to be able to rotate and touch things on iOS 7

  Background:  start on the buttons view
    When I touch the "Buttons" tab I should see the "buttons" view

  Scenario Outline: should be able to touch buttons in any orientation
    Then I rotate the home button to the <position> position
    Then I wait for rotation animation
    When I touch the <button_id> button I should see an <what>
    Then I dismiss the <what> with the cancel button
  Examples:
    | position | button_id    | what               |
    | down     | "show email" | email compose view |
    | down     | "show alert" | alert              |
    | up       | "show email" | email compose view |
    | down     | "show sheet" | action sheet       |
    | left     | "show alert" | alert              |
    | right    | "show email" | email compose view |
    | up       | "show sheet" | action sheet       |
    | left     | "show sheet" | action sheet       |
    | up       | "show alert" | alert              |
    | right    | "show sheet" | action sheet       |
    | left     | "show email" | email compose view |
    | right    | "show alert" | alert              |
