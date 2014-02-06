require_relative '../br_page'

class RecipeCollectionPage < BrPage

  def navbar_title
    'Recipes'
  end

  def mark
    'recipes page'
  end

  def go_back_to_home
    home = page(ScrollingHomePage)
    go_back_and_wait_for_view(home.mark())
    home
  end

end