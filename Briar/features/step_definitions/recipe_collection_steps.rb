Then(/^I look for the picture of the "([^"]*)"$/) do |food|
  expect_current_page(RecipeCollectionPage)
  @cp.scroll_to(@model.location_of_food(food))
end

Then(/^I scroll to the recipe with access (?:id|label) "([^"]*)"$/) do |mark|
  expect_current_page(RecipeCollectionPage)
  @cp.scroll_to_recipe_marked(mark)
end