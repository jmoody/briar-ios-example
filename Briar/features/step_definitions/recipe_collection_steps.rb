Then(/^I look for the picture of the "([^"]*)"$/) do |food|
  unless ios5?
    expect_current_page(RecipeCollectionPage)
    @cp.scroll_to(@model.location_of_food(food))
  end
end

Then(/^I scroll to the recipe with access (?:id|label) "([^"]*)"$/) do |mark|
  unless ios5?
    expect_current_page(RecipeCollectionPage)
    @cp.scroll_to_recipe_marked(mark)
  end
end