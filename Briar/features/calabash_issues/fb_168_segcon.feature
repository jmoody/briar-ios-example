@segmented_control
@fb_168
Feature: Interacting with segmented controls

  Background:  The segmented control is on the buttons tab
    When I touch the "Buttons" tab I should see the "buttons" view

  Scenario:  I should be able interact with the segmented control in down orientation
    Then I rotate the device so the home button is on the bottom
    Then I should see segmented control "image chooser" with titles "sand, grass, water"
    Then I should see segment "sand" in segmented control "image chooser" is selected
    Then I should see "zen sand sculpture"

    Then I touch the "grass" segment in segmented control "image chooser"
    Then I should see segment "sand" in segmented control "image chooser" is not selected
    Then I should see segment "water" in segmented control "image chooser" is not selected
    Then I should see segment "grass" in segmented control "image chooser" is selected
    Then I should see "cool grass"

    Then I touch the "water" segment in segmented control "image chooser"
    Then I should see segment "sand" in segmented control "image chooser" is not selected
    Then I should see segment "grass" in segmented control "image chooser" is not selected
    Then I should see segment "water" in segmented control "image chooser" is selected
    Then I should see "mossy brook"


  Scenario:  I should be able interact with the segmented control in left orientation
    Then I rotate the device so the home button is on the left
    Then I should see segmented control "image chooser" with titles "sand, grass, water"
    Then I should see segment "sand" in segmented control "image chooser" is selected
    Then I should see "zen sand sculpture"

    Then I touch the "grass" segment in segmented control "image chooser"
    Then I should see segment "sand" in segmented control "image chooser" is not selected
    Then I should see segment "water" in segmented control "image chooser" is not selected
    Then I should see segment "grass" in segmented control "image chooser" is selected
    Then I should see "cool grass"

    Then I touch the "water" segment in segmented control "image chooser"
    Then I should see segment "sand" in segmented control "image chooser" is not selected
    Then I should see segment "grass" in segmented control "image chooser" is not selected
    Then I should see segment "water" in segmented control "image chooser" is selected
    Then I should see "mossy brook"

  Scenario:  I should be able interact with the segmented control in right orientation
    Then I rotate the device so the home button is on the right
    Then I should see segmented control "image chooser" with titles "sand, grass, water"
    Then I should see segment "sand" in segmented control "image chooser" is selected
    Then I should see "zen sand sculpture"

    Then I touch the "grass" segment in segmented control "image chooser"
    Then I should see segment "sand" in segmented control "image chooser" is not selected
    Then I should see segment "water" in segmented control "image chooser" is not selected
    Then I should see segment "grass" in segmented control "image chooser" is selected
    Then I should see "cool grass"

    Then I touch the "water" segment in segmented control "image chooser"
    Then I should see segment "sand" in segmented control "image chooser" is not selected
    Then I should see segment "grass" in segmented control "image chooser" is not selected
    Then I should see segment "water" in segmented control "image chooser" is selected
    Then I should see "mossy brook"

  Scenario:  I should be able interact with the segmented control in top orientation
    Then I rotate the device so the home button is on the top
    Then I should see segmented control "image chooser" with titles "sand, grass, water"
    Then I should see segment "sand" in segmented control "image chooser" is selected
    Then I should see "zen sand sculpture"

    Then I touch the "grass" segment in segmented control "image chooser"
    Then I should see segment "sand" in segmented control "image chooser" is not selected
    Then I should see segment "water" in segmented control "image chooser" is not selected
    Then I should see segment "grass" in segmented control "image chooser" is selected
    Then I should see "cool grass"

    Then I touch the "water" segment in segmented control "image chooser"
    Then I should see segment "sand" in segmented control "image chooser" is not selected
    Then I should see segment "grass" in segmented control "image chooser" is not selected
    Then I should see segment "water" in segmented control "image chooser" is selected
    Then I should see "mossy brook"
