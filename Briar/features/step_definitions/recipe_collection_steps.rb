Then(/^I look for the picture of the "([^"]*)"$/) do |food|
  expect_current_page(RecipeCollectionPage)
  @cp.scroll_to(@model.location_of_food(food))
end