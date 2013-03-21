Then /^I should see the first view has the correct title$/ do
  should_see_view_with_text 'First View'
end

Then /^I should see the text related views after touching the Text tab$/ do
  touch_tabbar_item 'Text'
  should_see_view_after_animation 'text related'
  should_not_see_view_after_animation 'first view'
end
