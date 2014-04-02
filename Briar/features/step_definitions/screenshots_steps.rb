Then(/^I take a screenshot and embedded it$/) do
  screenshot_embed
  screenshot
end

Then(/^I touch the show email button$/) do
  touch_button_and_wait_for_view 'show email', 'compose email'
end

Then(/^I touch the show alert button$/) do
  touch_button_and_wait_for_view 'show alert', 'Briar Alert!'
  2.times { step_pause }
end

Then(/^I touch the show sheet button$/) do
  touch_button_and_wait_for_view 'show sheet', 'sheet!'
  2.times { step_pause }
end