@issue_189
Feature:  swiping left and right on ipad

  Background: get me to the text related view
    When I touch the Text tab, I should see the Text related part of the app

  Scenario: i should be able to swipe left and right on the text fields
    Then I swipe left on the top text field
    Then I should see the top text field has "swiped left"

    Then I swipe left on the bottom text field
    Then I should see the bottom text field has "swiped left"

    Then I swipe right on the top text field
    Then I should see the top text field has "swiped right"

    Then I swipe right on the bottom text field
    Then I should see the bottom text field has "swiped right"

  @wip
  Scenario Outline: i should be able to swipe left on the ipad - outline
    When I touch the Text tab, I should see the Text related part of the app
    And I rotate the device so the home button is on the bottom
    Then I swipe <swipe_dir> on the <tf_field> text field
    Then I should see the <tf_field> text field has <text>

  Examples: for left and right swiping
    | text            | tf_field  | swipe_dir  |
    | "swiped left"   | bottom    | left       |
    | "swiped right"  | bottom    | right      |
    | "swiped right"  | top       | right      |
    | "swiped left"   | top       | left       |

