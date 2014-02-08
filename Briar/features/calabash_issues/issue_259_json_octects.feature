@keyboard
@issue_259
@issue_269
Feature: uia_type_text should not throw octet problems

  Background: i am looking at the text related view
    Given I am looking at the Text tab
    And all the text input view have the email keyboard

  Scenario: i should be able to type one email address
    Then I type 1 email address into the text fields

  Scenario: i should be able to type one random string
    Then I type 1 random string with the full range of characters into the text fields

  Scenario: i should be able to type 2 email address
    Then I type 2 email addresses into the text fields

  # flickering because of UIA typeString() problem
  # https://github.com/calabash/calabash-ios/issues/269
  @flickering
  @xtc_smoke_json
  Scenario: i should be able to type 2 random string
    Then I type 2 random strings with the full range of characters into the text fields

#  Scenario: i should be able to type 10 email address
#    Then I type 10 email addresses into the text fields
#
#  Scenario: i should be able to type 10 random string
#    Then I type 10 random strings with the full range of characters into the text fields

#  Scenario: i should be able to type 1000 email address
#    Then I type 1000 email addresses into the text fields
#
#  @uia_type_string_stress
#  Scenario: i should be able to type 1000 random string
#    Then I type 1000 random strings with the full range of characters into the text fields

#  @uia_type_string_stress
#  Scenario: i should be able to type 100 random string
#    Then I type 100 random strings with the full range of characters into the text fields
#
#  @uia_type_string_stress
#  Scenario: i should be able to type 100 random string
#    Then I type 100 random strings with the full range of characters into the text fields
#
#  @uia_type_string_stress
#  Scenario: i should be able to type 100 random string
#    Then I type 100 random strings with the full range of characters into the text fields
#
#  @uia_type_string_stress
#  Scenario: i should be able to type 100 random string
#    Then I type 100 random strings with the full range of characters into the text fields
#
#  @uia_type_string_stress
#  Scenario: i should be able to type 100 random string
#    Then I type 100 random strings with the full range of characters into the text fields
#
#  @uia_type_string_stress
#  Scenario: i should be able to type 100 random string
#    Then I type 100 random strings with the full range of characters into the text fields
#
#  @uia_type_string_stress
#  Scenario: i should be able to type 100 random string
#    Then I type 100 random strings with the full range of characters into the text fields
#
#  @uia_type_string_stress
#  Scenario: i should be able to type 100 random string
#    Then I type 100 random strings with the full range of characters into the text fields
#
#  @uia_type_string_stress
#  Scenario: i should be able to type 100 random string
#    Then I type 100 random strings with the full range of characters into the text fields
#
#  @uia_type_string_stress
#  Scenario: i should be able to type 100 random string
#    Then I type 100 random strings with the full range of characters into the text fields
#
#  @uia_type_string_stress
#  Scenario: i should be able to type 100 random string
#    Then I type 100 random strings with the full range of characters into the text fields
#
#  @uia_type_string_stress
#  Scenario: i should be able to type 100 random string
#    Then I type 100 random strings with the full range of characters into the text fields
#
#  @uia_type_string_stress
#  Scenario: i should be able to type 100 random string
#    Then I type 100 random strings with the full range of characters into the text fields
