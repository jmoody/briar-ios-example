Then /^I should see the first view has the correct title$/ do
  should_see_view_with_text 'First View'
end

Then /^I should see the second view after touching the second tab$/ do
  touch_tabbar_item 'Second'
  should_see_view_after_animation 'second'
  should_not_see_view_after_animation 'first view'
end
