module Briar
  module Issue_128

    def touch_row_and_see_alert (row_id, alert_id)
      if query("tableViewCell marked:'#{row_id}'").empty?
        screenshot_and_raise "should see row marked '#{row_id}'"
      end

      if uia_available?
        touch_row row_id
        step_pause
        should_see_alert_with_message alert_id
      else
        touch_row_and_wait_to_see row_id, alert_id
        step_pause
      end
    end
  end
end

World(Briar::Issue_128)

When(/^I touch the last row I should see the i or j alert$/) do
  row_id = iphone_4in? ? 'j' : 'i'
  briar_scroll_to_row row_id
  step_pause
  alert_id = ios7? ? "'#{row_id}' is a great letter!" : "#{row_id} alert"
  touch_row_and_see_alert row_id, alert_id
end

Then(/^I dismiss the letter alert$/) do
  touch_alert_button('Cancel')
end

Then(/^I scroll down until the i row is partially hidden by the nav bar$/) do
  if iphone_4in?
    pending 'this test will only work on iphone 3.5in'
  end

  2.times do
    scroll("tableView marked:'table'", 'down')
    step_pause
  end

  row_id = 'i'
  briar_scroll_to_row row_id
  msg = "should see row marked '#{row_id}'"
  wait_for({:timeout_message => msg}) do
    query("tableViewCell marked:'#{row_id}'").count == 1
  end

end

When(/^I touch the first row I should see the i alert$/) do
  row_id = 'i'
  alert_id = ios7? ? "'i' is a great letter!" : 'i alert'
  touch_row_and_see_alert row_id, alert_id
end

When(/^I touch the "([^"]*)" row I should the the associated alert$/) do |row_id|
  alert_id = ios7? ? "'#{row_id}' is a great letter!" : "#{row_id} alert"
  touch_row_and_see_alert row_id, alert_id
end
