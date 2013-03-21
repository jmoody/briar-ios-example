@keyboard
Feature: briar keyboard features

  Background: get us to the text related views so we can test the test the keyboard
    When I touch the "Text" tab I should see the "text related" view

  Scenario: i want to be able to touch the delete key
    # unexpected
    # Then /^I (?:press|touch) the "([^\"]*)" (?:input|text) field$/ do |name|
    #   touch("textField placeholder:'#{name}'")
    #   sleep(STEP_PAUSE)
    # end
    # Then I touch the "input" text field
    Then I touch "input"
    Then I should see a "done text editing" button in the navbar
    Then I turn off spell checking and capitalization
    Then I use the keyboard to enter "abc"
    Then I touch the delete key
    Then I should see "input" text field with text "ab"
    Then I am done text editing
    Then I should not see a "done text editing" button in the navbar
    Then I should not see the keyboard

  Scenario:  i want to test my changes to the calabash predefined step touch the text field
    # look by placeholder
    Then I touch the "placeholder!" text field
    Then I am done text editing

    # dismiss the keyboard
    Then I am done text editing
    Then I should not see the keyboard

    # look by mark
    # expected to fail until the proposed fix is installed
    Then I touch the "input" text field
    Then I should see the keyboard


