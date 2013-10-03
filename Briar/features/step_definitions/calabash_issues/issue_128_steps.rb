module Briar
  module Issue_128

    def touch_row_and_see_alert (row_id, alert_id)
      if query("tableViewCell marked:'#{row_id}'").empty?
        screenshot_and_raise "should see row marked '#{row_id}'"
      end
      touch_row_and_wait_to_see row_id, alert_id
    end
  end
end

World(Briar::Issue_128)

When(/^I touch the last row I should see the i or j alert$/) do
  row_id = device.iphone_5? ? 'j' : 'i'
  briar_scroll_to_row row_id
  step_pause
  alert_id = device.ios7? ? 'Alphabet Alert' : "#{row_id} alert"
  touch_row_and_see_alert row_id, alert_id
end

When(/^I touch the "([^"]*)" row I should see the "([^"]*)"$/) do |row_id, alert_id|
  touch_row_and_see_alert row_id, alert_id
end

Then(/^I dismiss the letter alert$/) do
  touch_alert_button('Cancel')
end

Then(/^I scroll down until the i row is partially hidden by the nav bar$/) do
  if device.iphone_5?
    pending 'this test will only work on iphone 3.5in'
  end

  2.times do
    scroll("tableView marked:'alphabet'", 'down')
    step_pause
  end

  row_id = 'i'
  briar_scroll_to_row row_id
    wait_for_animation
  unless query("tableViewCell marked:'#{row_id}'").count == 1
    screenshot_and_raise "should see row marked '#{row_id}'"
  end

end

When(/^I touch the first row I should see the i alert$/) do
  row_id = 'i'
  alert_id = 'i alert'
  touch_row_and_see_alert row_id, alert_id
end

When(/^I touch the "([^"]*)" row I should the the associated alert$/) do |row_id|
  alert_id = device.ios7? ? 'Alphabet Alert' : "#{row_id} alert"
  touch_row_and_see_alert row_id, alert_id
end
