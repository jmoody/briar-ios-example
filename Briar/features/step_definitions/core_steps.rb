module Briar
  module Core

  end
end

World(Briar::Core)

Given(/^I am looking at the Text tab$/) do
  navigate_to_text_related_tab
end

Then /^I should see the text related views after touching the Text tab$/ do
  navigate_to_text_related_tab
end

When(/^I touch the Text tab, I should see the Text related part of the app$/) do
  navigate_to_text_related_tab
end

Given(/^that I am looking at the Date tab$/) do
  unless view_exists? 'date related'
    touch_tabbar_item 'Date'
    wait_for_view 'date related'
  end
end

Then(/^I am looking at the Tables tab$/) do
  trait = 'tables'
  unless tabbar_visible?
    screenshot_and_raise 'expected tabbar to be visible - cannot navigate to Tables tab'
  end

  unless view_exists? trait
    touch_tabbar_item 'Tables'
    wait_for_view trait
  end
end


#noinspection RubyUnusedLocalVariable
Then(/^I say, "([^"]*)"$/) do |arg|

end

#noinspection RubyUnusedLocalVariable
Then(/^he said, "([^"]*)"$/) do |arg|

end

And(/^you will get no hurt now$/) do

end

