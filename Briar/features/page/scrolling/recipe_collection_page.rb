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

    sleep(0.2)
    timeout = BRIAR_WAIT_TIMEOUT
    msg = "waited '#{timeout}' seconds but did not see navbar back button"
    wait_for(wait_opts(msg, timeout)) do
      not query('navigationItemButtonView first').empty?
    end
    # not yet
    # wait_for_none_animating

    touch('navigationItemButtonView first')
    step_pause
    wait_for_view home.mark

    home
  end

  def scroll_to(item_hash)
    scroll_to_collection_view_item(item_hash[:item], item_hash[:section])
    wait_for_view(item_hash[:id])
    step_pause
  end

  def scroll_to_recipe_marked(mark)
    scroll_to_collection_view_item_with_mark(mark)
    wait_for_view(mark)
    step_pause
  end

end