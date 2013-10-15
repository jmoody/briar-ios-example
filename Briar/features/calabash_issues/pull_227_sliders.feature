@slider
@wip
Feature: testing the slider operation

  Background: navigate to the sliders tab
    When I touch the "Sliders" tab I should see the "sliders" view

  Scenario: emoticon should change when slider is moved
    When I change the "emotions" slider to 2, I should see the "happy" emoticon
    When I change the "emotions" slider to -2, I should see the "sad" emoticon
    When I change the "emotions" slider to -0.4, I should see the "bored" emoticon



