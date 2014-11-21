# not stable enough for the xtc
@not_xtc
@keyboard
@rotation
@issue_265
@issue_259
@ipad_only
Feature: iPad Keyboard Modes: Split, Docked, Undocked

  Background: navigate to the text related tab
    Given I am looking at the Text tab
    And all the text input view have the default keyboard
    And I have touched the "top" text field

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

  # outlines are NYI on XTC
  @not_xtc
  @issue_310
  @ipad_only
  Scenario Outline: I should be able to use the keyboard regardless of orientation or mode
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

  # outlines are NYI on XTC
  @not_xtc
  @ipad_only
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
