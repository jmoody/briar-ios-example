Given(/^I see the views that scroll home view$/) do
  @cp = page(ScrollingHomePage).navigate_to
end


And(/^I go to the alphabet table$/) do
  expect_current_page(ScrollingHomePage)
  # todo Alphabet Page
  @cp.goto_alphabet_table
  @cp = nil
end

Then(/^I can go back to the scrolling home view$/) do
  if @cp.nil?
    @cp = page(ScrollingHomePage).navigate_to
  elsif cp_is? RecipeCollectionPage
    @cp = @cp.go_back_to_home
  else
    pending "cannot go back to scrolling home from this page '#{@cp}'"
  end
end


And(/^I go to the collection view page$/) do
  unless ios5?
    expect_current_page(ScrollingHomePage)
    @cp = @cp.goto_recipes_page
  end
end