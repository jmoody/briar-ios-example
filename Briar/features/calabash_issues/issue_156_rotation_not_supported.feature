@rotation
@issue_156
Feature: testing what happens when a view controller does not support an orientation

  Background: get me to the date picker view
    Given that I am looking at the Date tab
    Given the device is in the portrait orientation

  # might be flickering on iPad _devices_
  Scenario: i should not be able to rotate the date view to landscape
    # predefined step - calls Calabash rotate

    Then I rotate device left
    Then the status bar orientation should be "down"
    Then I rotate device right
    Then the status bar orientation should be "down"

    # step defined locally - calls Calabash rotate_home_button_to
    When I rotate the device so the home button is on the right
    Then the status bar orientation should be "down"


    ### UNEXPECTED ###
    # a bug in the implementation of how rotate_home_button_to
    # even if the rotation fails, the device orientation is changed
    # which means that as the there will be cases where the device
    # orientation will return a value that is not visually consistent
    # with the state simulator

    ### UPDATE ####
    # using the status_bar_orientation instead of the device_orientation
    # seems to have fixed this issue so i am changing the expect orientation
    # from "up" to "down"
    When I rotate the device so the home button is on the left
    Then the status bar orientation should be "down"
    #Then the status bar orientation should be "up"
    ##################

