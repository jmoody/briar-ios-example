module Briar
  module Text_Related
    def swipe_on_text_field(dir, field)
      dev = device
      if dev.ios7? && dev.simulator?
        pending 'iOS 7 simulator detected: due to a bug in the iOS Simulator, swiping does not work'
      end
      tf = "#{field} tf"
      wait_for_view tf, 2
      swipe(dir, {:query => "textField marked:'#{tf}'"})
      2.times { step_pause }
      tf
    end
  end
end

World(Briar::Text_Related)

Then(/^I swipe (left|right) on the (top|bottom) text field$/) do |dir, field|
  swipe_on_text_field dir, field
end

Then(/^I should see the (top|bottom) text field has "([^"]*)"$/) do |field, text|
  tf = "#{field} tf"
  should_see_text_field_with_text tf, text
  2.times { step_pause }
end

