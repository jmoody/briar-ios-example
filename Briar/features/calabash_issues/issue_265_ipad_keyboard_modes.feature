@keyboard
@rotation
@issue_265
@issue_259
Feature: ipad keyboard modes

  Background: navigate to the text related tab
    Given I am looking at the Text tab
    And all the text input view have the default keyboard
    And I have touched the "top" text field

  # NB: tried using an outline for these tests, but i found flickering tests
  # and the html report was not providing enough information
  #  Scenario Outline: i should be able tell what mode the keyboard is in regardless of orientation
  #    Then I should be able to <mode1> the keyboard
  #    Then I check the keyboard mode is stable across orientations
  #    Then I should be able to <mode2> the keyboard
  #    Then I check the keyboard mode is stable across orientations
  #    Then I should be able to <mode3> the keyboard
  #    Then I check the keyboard mode is stable across orientations
  #  Examples:
  #    | mode1  | mode2  | mode3  |
  #    | dock   | undock | dock   |
  #    | dock   | split  | dock   |
  #    | undock | dock   | undock |
  #    | undock | split  | undock |
  #    | split  | dock   | split  |
  #    | split  | undock | split  |

  Scenario: DOWN docked to undocked to docked
    Then I rotate the device so the home button is on the bottom
    Then I should be able to dock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to undock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to dock the keyboard
    Then I check the keyboard mode is stable across orientations

  Scenario: DOWN docked to split to docked
    Then I rotate the device so the home button is on the bottom
    Then I should be able to dock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to split the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to dock the keyboard
    Then I check the keyboard mode is stable across orientations

  Scenario: DOWN undock to dock to undock
    Then I rotate the device so the home button is on the bottom
    Then I should be able to undock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to dock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to undock the keyboard
    Then I check the keyboard mode is stable across orientations

  Scenario: DOWN undock to split to undock
    Then I rotate the device so the home button is on the bottom
    Then I should be able to undock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to split the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to undock the keyboard
    Then I check the keyboard mode is stable across orientations

  Scenario: UP split to dock to split
    Then I rotate the device so the home button is on the top
    Then I should be able to split the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to dock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to split the keyboard
    Then I check the keyboard mode is stable across orientations

  Scenario: UP split to undock to split
    Then I rotate the device so the home button is on the top
    Then I should be able to split the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to undock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to split the keyboard
    Then I check the keyboard mode is stable across orientations

  Scenario: UP docked to undocked to docked
    Then I rotate the device so the home button is on the top
    Then I should be able to dock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to undock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to dock the keyboard
    Then I check the keyboard mode is stable across orientations

  Scenario: UP docked to split to docked
    Then I rotate the device so the home button is on the top
    Then I should be able to dock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to split the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to dock the keyboard
    Then I check the keyboard mode is stable across orientations

  Scenario: LEFT undock to dock to undock
    Then I rotate the device so the home button is on the left
    Then I should be able to undock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to dock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to undock the keyboard
    Then I check the keyboard mode is stable across orientations

  Scenario: LEFT undock to split to undock
    Then I rotate the device so the home button is on the left
    Then I should be able to undock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to split the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to undock the keyboard
    Then I check the keyboard mode is stable across orientations

  Scenario: LEFT split to dock to split
    Then I rotate the device so the home button is on the left
    Then I should be able to split the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to dock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to split the keyboard
    Then I check the keyboard mode is stable across orientations

  Scenario: LEFT  split to undock to split
    Then I rotate the device so the home button is on the left
    Then I should be able to split the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to undock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to split the keyboard
    Then I check the keyboard mode is stable across orientations

  Scenario: RIGHT docked to undocked to docked
    Then I rotate the device so the home button is on the right
    Then I should be able to dock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to undock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to dock the keyboard
    Then I check the keyboard mode is stable across orientations

  Scenario: RIGHT docked to split to docked
    Then I rotate the device so the home button is on the right
    Then I should be able to dock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to split the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to dock the keyboard
    Then I check the keyboard mode is stable across orientations

  Scenario: RIGHT undock to dock to undock
    Then I rotate the device so the home button is on the right
    Then I should be able to undock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to dock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to undock the keyboard
    Then I check the keyboard mode is stable across orientations

  Scenario: RIGHT undock to split to undock
    Then I rotate the device so the home button is on the right
    Then I should be able to undock the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to split the keyboard
    Then I check the keyboard mode is stable across orientations
    Then I should be able to undock the keyboard
    Then I check the keyboard mode is stable across orientations


  # NB:  tried using an outline, but found flickering tests and html report
  # was not giving enough information
  #  Scenario Outline: i should be able to detect and change the keyboard mode
  #    Then I rotate the device <n> times in a random direction
  #    Then I should be able to <op1> the keyboard
  #    Then I rotate the device <n> times in a random direction
  #    Then I should be able to <op2> the keyboard
  #    Then I rotate the device <n> times in a random direction
  #    Then I should be able to <op3> the keyboard
  #  Examples:
  #    | n | op1    | op2    | op3    |
  #    | 2 | split  | undock | dock   |
  #    | 2 | undock | split  | dock   |
  #    | 2 | dock   | split  | undock |
  #    | 2 | dock   | undock | split  |

  Scenario: with rotation split to undock to dock
    Then I rotate the device 2 times in a random direction
    Then I should be able to split the keyboard
    Then I rotate the device 2 times in a random direction
    Then I should be able to undock the keyboard
    Then I rotate the device 2 times in a random direction
    Then I should be able to dock the keyboard

  Scenario: with rotation undock to split to dock
    Then I rotate the device 2 times in a random direction
    Then I should be able to undock the keyboard
    Then I rotate the device 2 times in a random direction
    Then I should be able to split the keyboard
    Then I rotate the device 2 times in a random direction
    Then I should be able to dock the keyboard

  Scenario: with rotation dock to split to undock
    Then I rotate the device 2 times in a random direction
    Then I should be able to dock the keyboard
    Then I rotate the device 2 times in a random direction
    Then I should be able to split the keyboard
    Then I rotate the device 2 times in a random direction
    Then I should be able to undock the keyboard

  Scenario: with rotation dock to undock to split
    Then I rotate the device 2 times in a random direction
    Then I should be able to dock the keyboard
    Then I rotate the device 2 times in a random direction
    Then I should be able to undock the keyboard
    Then I rotate the device 2 times in a random direction
    Then I should be able to split the keyboard

  # flickering
  # iPhone 6 sim and device - NO_LAUNCH
  #  - cannot seem to consistently find the ` character on iphone
  # iPad 1 iOS 5 and iPad Simulator iOS 6 no launch because
  #  - the text is sometimes entered into the top tf instead of the bottom text field
  # iOS 7
  #  - uia_type_string reports that it cannot type a string, but the string has been typed
  #  - problem is issue 310
  # outlines are NYI on XTC
  @issue_310
  @flickering
  @not_xtc
  Scenario Outline: i should be able to use the keyboard regardless of orientation or mode
    Given I am looking at the Text tab
    And I have touched the "top" text field
    Then I rotate the device <rotate> times in a random direction
    Then I put the keyboard into a random mode
    Then I type <emails> email addresses into the text fields
    Then I rotate the device <rotate> times in a random direction
    Then I type <random> random strings with the full range of characters into the text fields
  Examples:
    | rotate | emails | random |
    | 3      | 1      | 1      |
    | 3      | 1      | 1      |
    | 3      | 1      | 1      |

  # flickering on iPad 1 iOS 5
  # outlines are NYI on XTC
  @not_xtc
  @flickering
  Scenario Outline: i should be able to dismiss the ipad keyboard
    Given I am looking at the Text tab
    And I have touched the "top" text field
    Then I rotate the device <n> times in a random direction
    Then I should be able to <op> the keyboard
    Then I should be able to dismiss the ipad keyboard
  Examples:
    | n | op     |
    | 3 | dock   |
    | 3 | undock |
    | 3 | split  |
