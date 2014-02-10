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

  def scroll_to(item_hash)
    scroll_to_collection_view_item(item_hash[:item], item_hash[:section])
    wait_for_view(item_hash[:id])
    step_pause
  end

end