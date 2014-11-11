@issue_310
@keyboard
Feature:  keyboard_enter_text should fail if key does not exist
  In order to catch up on my beauty sleep
  As a calabash developer
  I want uia_type_string to start behaving itself.

  Background: get me to the text tab
    Given I am looking at the Text tab

  Scenario: try type a key that does not exist on text field keyboard
    And one of the text fields has the default keyboard showing
    When I type a key that does not exist it should raise an exception

  Scenario: try type a key that does not exist on text view keyboard
    And one of the text views has the default keyboard showing
    When I type a key that does not exist it should raise an exception
