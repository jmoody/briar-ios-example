When(/^I touch the last row I should see the i or j alert$/) do
  row_id = gestalt.is_iphone_5? ? 'j' : 'i'
  macro %Q|I touch the "#{row_id}" row I should see the "#{row_id} alert"|
end

When(/^I touch the "([^"]*)" row I should see the "([^"]*)"$/) do |row_id, alert_id|
  # sanity check - can we see the row?
  if query("tableViewCell marked:'#{row_id}'").empty?
    screenshot_and_raise "should see row marked '#{row_id}'"
  end

  touch_transition("tableViewCell marked:'#{row_id}'",
                   "alertView marked:'#{alert_id}'",
                   {:timeout=>TOUCH_TRANSITION_TIMEOUT,
                    :retry_frequency=>TOUCH_TRANSITION_RETRY_FREQ})
end

Then(/^I dismiss the letter alert$/) do
  touch('alertView child button')
  wait_for_animation
end
