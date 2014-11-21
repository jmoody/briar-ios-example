@rotation
@issue_156
Feature: Swipes should work in all orientations

  Background: I should see the text related view
    When I touch the Text tab, I should see the Text related part of the app

  Scenario: Home button down, swipe left, on the top text field
    Then I rotate the device so the home button is on the bottom
    Then I swipe left on the top text field
    Then I should see the top text field has "swiped left"

  Scenario: Home button top, swipe right, on the bottom text field
    Then I rotate the device so the home button is on the top
    Then I swipe right on the bottom text field
    Then I should see the bottom text field has "swiped right"

  Scenario: Home button left, swipe right, on the bottom text field
    Then I rotate the device so the home button is on the left
    Then I swipe right on the bottom text field
    Then I should see the bottom text field has "swiped right"

  Scenario: Home button right, swipe right, on the bottom text field
    Then I rotate the device so the home button is on the right
    Then I swipe right on the bottom text field
    Then I should see the bottom text field has "swiped right"

  Scenario: Home button down, swipe left, on the bottom text field
    Then I rotate the device so the home button is on the bottom
    Then I swipe left on the bottom text field
    Then I should see the bottom text field has "swiped left"

  Scenario: Home button right, swipe left, on the top text field
    Then I rotate the device so the home button is on the right
    Then I swipe left on the top text field
    Then I should see the top text field has "swiped left"

  Scenario: Home button top, swipe right, on the top text field
    Then I rotate the device so the home button is on the top
    Then I swipe right on the top text field
    Then I should see the top text field has "swiped right"

  Scenario: Home button down, swipe right, on the top text field
    Then I rotate the device so the home button is on the bottom
    Then I swipe right on the top text field
    Then I should see the top text field has "swiped right"

  Scenario: Home button left, swipe right, on the top text field
    Then I rotate the device so the home button is on the left
    Then I swipe right on the top text field
    Then I should see the top text field has "swiped right"

  Scenario: Home button right, swipe left, on the bottom text field
    Then I rotate the device so the home button is on the right
    Then I swipe left on the bottom text field
    Then I should see the bottom text field has "swiped left"

  Scenario: Home button right, swipe left, on the bottom text field
    Then I rotate the device so the home button is on the top
    Then I swipe left on the bottom text field
    Then I should see the bottom text field has "swiped left"

  Scenario: Home button right, swipe right, on the bottom text field
    Then I rotate the device so the home button is on the bottom
    Then I swipe right on the bottom text field
    Then I should see the bottom text field has "swiped right"

  Scenario: Home button right, swipe right, on the top text field
    Then I rotate the device so the home button is on the right
    Then I swipe right on the top text field
    Then I should see the top text field has "swiped right"

  Scenario: Home button top, swipe left, on the top text field
    Then I rotate the device so the home button is on the top
    Then I swipe left on the top text field
    Then I should see the top text field has "swiped left"

  Scenario: Home button left, swipe left, on the bottom text field
    Then I rotate the device so the home button is on the left
    Then I swipe left on the bottom text field
    Then I should see the bottom text field has "swiped left"

  Scenario: Home button left, swipe left, on the top text field
    Then I rotate the device so the home button is on the left
    Then I swipe left on the top text field
    Then I should see the top text field has "swiped left"
