@email
Feature: email features
  in order to test the briar email steps i want an email view

  Background:  get the first view in a shape to test email view
    When we are testing on the simulator or a device configured to send emails
    Then I touch the "email" button and wait for the "compose email" view

  Scenario: i should be able to identify an email view
    Then I should see email view with body that contains "next to a calabash, it is my favorite"
    Then I should see email view with "i love this briar pipe!" in the subject
    Then I should see email view with text like "love this briar" in the subject
    Then I should see email view with recipients "example@example.com"
    Then I should see email view with recipients "example@example.com, foo@bar.com"
    Then I should see email view with recipients "example@example.com,foo@bar.com"
    When I cancel email editing I should see the "first" view




