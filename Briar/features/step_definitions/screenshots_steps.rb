Then(/^I take a screenshot and embedded it$/) do
  screenshot_embed
end

Then(/^I touch the show email button$/) do
  touch_button_and_wait_for_view 'show email', 'compose email'
end