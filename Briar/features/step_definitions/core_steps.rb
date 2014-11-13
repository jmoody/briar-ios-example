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

Then(/^I am looking at the Alphabet table$/) do
  unless tabbar_visible?
    screenshot_and_raise 'expected tabbar to be visible - cannot navigate to Tables tab'
  end

  if cp_is?(ScrollingHomePage)
    @cp.goto_alphabet_table
  else
    @cp = page(ScrollingHomePage).navigate_to
    @cp.goto_alphabet_table
  end

end

Given(/^I am looking at the web view page$/) do
  unless tabbar_visible?
    screenshot_and_raise 'expected tabbar to be visible - cannot navigate to Tables tab'
  end

  if cp_is?(ScrollingHomePage)
    @cp.goto_web_view_page
  else
    @cp = page(ScrollingHomePage).navigate_to
    @cp.goto_web_view_page
  end
end


When(/^I touch a link to reveal a message$/) do
  unless element_does_not_exist("webView css:'#secret-message'")
    screenshot_and_raise 'expected secret message to initially be hidden'
  end
  touch("webView css:'a#show-message-link'")
end

Then(/^I should see the message is revealed$/) do
  wait_for_element_exists("webView css:'#secret-message'",
                          :timeout_message => 'expected secret message to be revealed')
end

#noinspection RubyUnusedLocalVariable
Then(/^I say, "([^"]*)"$/) do |arg|

end

#noinspection RubyUnusedLocalVariable
Then(/^he said, "([^"]*)"$/) do |arg|

end

And(/^you will get no hurt now$/) do

end

