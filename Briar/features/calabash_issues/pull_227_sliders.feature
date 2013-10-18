@sliders
@rotation
Feature: testing the slider operation

  Background: navigate to the sliders tab
    When I touch the "Sliders" tab I should see the "sliders" view
    Then I should see the emotions slider group at the top of the view
    Then I should see the slider table
    Then I rotate the device 2 times in a random direction

  Scenario: emoticon should change when slider is moved
    When I change the "emotion" slider to 2, I should see the "happy" emoticon
    When I change the "emotion" slider to -2, I should see the "sad" emoticon
    When I change the "emotion" slider to -0.4, I should see the "bored" emoticon

  Scenario: i should be able to interact with sliders in table rows
    Then I scroll to the "weather" row
    Then I observe that it is raining
    Then I scroll to the "office" row
    Then I decide we really need a paper airplane in the office
    Then I scroll to the "science" row
    Then I note that used the telescope in my experiment









