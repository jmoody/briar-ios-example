@rotation
@issue_156
Feature: testing rotation

  ### UNEXPECTED ###
  # the default profile in cucumber.yml sets NO_LAUNCH=1 and --tags ~@launch
  # so if you tag a Scenario (or a feature) with @launch, they will not be
  # using the default profile
  #
  # use -p launch to run default profile against @launch tags
  #
  # this is a hold-over from several production apps where tests take 1+ hours
  # to run even when the app is not restarted every time
  ##################

  ###########
  # launching in the sim with instruments causes the device to rotate back to
  # portrait for iphone
  @iphone_only
  @launch
  Scenario: 1 of 2 testing orientation with back-to-back launches
    When I rotate the device left, I should see the status bar and device have the same orientation

  @iphone_only
  @launch
  Scenario: 2 of 2 testing orientation with back-to-back launches
    Then the device orientation should be "unknown" on the simulator and "down" on device
    And the status bar orientation should be "down"
  ###########

  ###########
  # launch the app manually
  # put the device into any rotation
  # run tests
  @iphone_only
  @no_launch
  Scenario: 1 of 2 testing orientation with NO_LAUNCH=1 back-to-back launches
    When I rotate the device right, I should see the status bar and device have the same orientation

  @iphone_only
  @no_launch
  Scenario: 2 of 2 testing orientation with NO_LAUNCH=1 back-to-back launches
    Then the orientation of the status bar and device should be same
  ###########

  @launch
  Scenario: launch - 1 of 2 test rotation to any direction
    Then I rotate the device 4 times in a random direction
    Then the orientation of the status bar and device should be same

  @launch
  Scenario: launch - 2 of 2 test rotation to any direction
    Then the device orientation should be "unknown" on the simulator and "down" on device
    And the status bar orientation should be "down"

  Scenario: no launch - 1 of 1 test rotation to any direction
    Then I rotate the device 4 times in a random direction
    Then the orientation of the status bar and device should be same

  @launch
  Scenario: launch - we should be able rotate the device to any orientation
    Then I rotate the device so the home button is on the right
    Then the orientation of the status bar and device should be same

  Scenario: no launch - we should be able rotate the device to any orientation
    Then I rotate the device so the home button is on the right
    Then the orientation of the status bar and device should be same

