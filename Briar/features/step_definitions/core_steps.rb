Then /^I should see the first view has the correct title$/ do
  should_see_view_with_text 'First View'
end

Then /^I should see the text related views after touching the Text tab$/ do
  touch_tabbar_item 'Text'
  wait_for_view 'text related'
  wait_for_view_to_disappear 'first view'
end

