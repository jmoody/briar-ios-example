@issue_323
Feature: Accessing the iOS keychain
  In order to test apps that use the iOS keychain
  As a calabash framework tester
  I want a way to query and modify the keychain

  Scenario: i want to query the keychain after the app saves data
    Given that the keychain is clear
    And I am looking at the Text tab

    When I type "username" into the user text field
    And I type "password" into the pass text field

    Then I am done text editing
    And I press the "Save to Keychain" button

    Then the keychain should contain the account password "password" for "username"

  Scenario: i want to be able to set the keychain contents from calabash
    Given that the keychain contains the account password "mypass" for "myuser"
    And I am looking at the Text tab
    Then I should see the user text field has "myuser"
    And I should see the pass text field has "mypass"
