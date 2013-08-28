@issue_189
Feature:  swiping left and right on ipad

  Background: get me to the text related view
    When I touch the Text tab, I should see the Text related part of the app

  Scenario Outline: i should be able to swipe left on the ipad
    Then I swipe <swipe> on the <field> text field
    Then I should see the <field> text field has <text>

  # mixed the orientations up
  Examples: for exhaustive rotation and swipe testing
    | swipe | field  | text           |
    | left  | top    | "swiped left"  |
    | left  | bottom | "swiped left"  |
    | right | bottom | "swiped right" |
    | right | top    | "swiped right" |

