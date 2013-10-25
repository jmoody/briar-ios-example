module Briar
  module Core
    def navigate_to_text_related_tab
      unless view_exists? 'text related'
        step_pause
        touch_tabbar_item 'Text'
        wait_for_view 'text related'
      end
    end
  end
end

World(Briar::Core)

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
