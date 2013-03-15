@email
Feature: email features
  in order to test the briar email steps i want an email view

  Background:  get the first view in a shape to test email view
    Then I touch the "email" button and wait for the "compose email" view

  Scenario: i should be able to identify an email view
    Then I should see email view with body that contains "next to a calabash, it is my favorite"
    Then I should see email view with "i love this briar pipe!" in the subject
    Then I should see email view with text like "love this briar" in the subject
    Then I should see email view with recipients "example@example.com"
    Then I should see email view with recipients "example@example.com, foo@bar.com"
    When I cancel email editing I should see the "first view" view



#
#    When /^I cancel email editing I should see the "([^"]*)" view$/ do |view_id|
#  should_see_mail_view
#  wait_for_animation
#
#  if gestalt.is_ios6?
#  puts "WARN: iOS6 detected - navbar cancel button is not visible on iOS 6"
#  else
#  touch_navbar_item "Cancel"
#  wait_for_animation
#  touch_transition("button marked:'Delete Draft'",
#  "view marked:'#{view_id}'",
#  {:timeout=>TOUCH_TRANSITION_TIMEOUT,
#  :retry_frequency=>TOUCH_TRANSsITION_RETRY_FREQ})
#  end
#  end

#
#    Then /^I touch the "([^"]*)" row and wait to see the email view$/ do |row_id|
#  should_see_row row_id
#  touch("tableViewCell marked:'#{row_id}'")
#  wait_for_animation
#  should_see_mail_view
#  end



