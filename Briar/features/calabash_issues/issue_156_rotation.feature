@rotation
@issue_156
Feature: testing rotation

  ### UNEXPECTED ###
  # the default profile in cucumber.yml sets NO_LAUNCH=1 and --tags ~@launch
  # so if you tag a Scenario (or a feature) with @launch, they will not be run
  # using the default profile
  #
  # use -p launch to run default profile against @launch tags
  #
  ##################

  ### TEST RELAUNCHING BEHAVIOR ON SIMULATOR ###
  # launching in the sim with instruments causes the device to rotate back to
  # portrait for iphone but not the ipad
  @launch
  @iphone_only
  @simulator_only
  Scenario: iPhone 1 of 2 testing orientation with back-to-back launches
    When I rotate the device left, I should see the status bar and device have the same orientation

  @launch
  @iphone_only
  @simulator_only
  Scenario: iPhone 2 of 2 testing orientation with back-to-back launches on
    Then the device orientation should be "unknown" on the simulator and "down" on device
    And the status bar orientation should be "down"

  @launch
  @ipad_only
  @simulator_only
  Scenario: iPad 1 of 2 testing orientation with back-to-back launches
    When I rotate the device left, I should see the status bar and device have the same orientation


  @launch
  @ipad_only
  @simulator_only
  Scenario: iPad 2 of 2 testing orientation with back-to-back launches
    Then the device orientation should be "unknown" on the simulator and "left" on device
    And the status bar orientation should be "down"
  ### END TEST RELAUNCHING ON SIMULATOR ###

  ###########
  # launch the app manually
  # put the device into any rotation
  # run tests
  @no_launch
  Scenario: 1 of 2 testing orientation with NO_LAUNCH=1 back-to-back launches
    Given that I have not launched the app
    When I rotate the device right, I should see the status bar and device have the same orientation

  # flickering on iPhone iOS 7 simulator - it should not even have been run?!?
  @foobar
  @no_launch
  Scenario: 2 of 2 testing orientation with NO_LAUNCH=1 back-to-back launches
    Given that I have not launched the app
    Then the orientation of the status bar and device should be same
  ###########

  @iphone_only
  @launch
  Scenario: launch - 1 of 2 test rotation to any direction
    Then I rotate the device 4 times in a random direction
    Then the orientation of the status bar and device should be same

  # flickers if the device does not start in 'down' orientation
  # can fix with a pre hook that forces the orientation to 'down'
  # todo fix flickering rotation test with pre hook that forces orientation to 'down'
  # XTC devices are all face-up. :)
  @not_xtc
  @iphone_only
  @launch
  @flickering
  Scenario: launch - 2 of 2 test rotation to any direction
    Then the device orientation should be "unknown" on the simulator and "down" on device
    And the status bar orientation should be "down"

  ############
  # cannot test on ipad because restarting sim does _not_ reset orientation
  #
  #  @ipad_only
  #  @launch
  #  Scenario: launch - 1 of 2 test rotation to any direction
  #    Then I rotate the device 4 times in a random direction
  #    Then the orientation of the status bar and device should be same
  #
  #
  #  @ipad_only
  #  @launch
  #  Scenario: launch - 2 of 2 test rotation to any direction
  #    Then the device orientation should be "unknown" on the simulator and "down" on device
  #    And the status bar orientation should be "down"
  #  #####

  @no_launch
  Scenario: no launch - 1 of 1 test rotation to any direction
    Then I rotate the device 4 times in a random direction
    Then the orientation of the status bar and device should be same

  @ipad_only
  Scenario: should be able to rotate to the home position
    Then I rotate the device 4 times in a random direction
    Then I rotate the device so the home button is on the bottom
    Then the orientation of the status bar and device should be same


