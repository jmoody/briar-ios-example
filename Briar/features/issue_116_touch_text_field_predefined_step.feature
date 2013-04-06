@issue_116
Feature: issue 116 - should be able to touch text field by mark or placeholder
  https://github.com/calabash/calabash-ios/pull/116

  Background: get us to the text related views so we can test the test the new feature
    When I touch the "Text" tab I should see the "text related" view

  # this is unexpected:
  #
  # Then /^I (?:press|touch) the "([^\"]*)" (?:input|text) field$/ do |name|
  #   touch("textField placeholder:'#{name}'")
  #   sleep(STEP_PAUSE)
  # end
  #
  @failing
  Scenario: i should be able to touch the text field by mark or placeholder
    # look by placeholder
    Then I touch the "placeholder!" text field

    # dismiss the keyboard
    Then I am done text editing
    Then I should not see the keyboard

    # look by mark
    # expected to fail until the proposed fix is installed
    Then I touch the "input" text field
    Then I should see the keyboard
    Then I am done text editing
