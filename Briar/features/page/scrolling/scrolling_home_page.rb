require_relative '../home_page'


class ScrollingHomePage < HomePage

  def navbar_title
    'Views That Scroll'
  end

  def mark
    'scrolling views home'
  end

  def tabbar_item_mark
    'Scrolling Views'
  end

  def _touch_row(row_mark)
    briar_scroll_to_row_and_touch(row_mark, {:table_id => 'table'})
  end

  def goto_alphabet_table
    _touch_row('alphabet')
    wait_for_view('alphabet')
  end

  def goto_recipes_page
    page = page(RecipeCollectionPage)
    _touch_row('recipes')
    wait_for_view(page.mark())
    page
  end

  def goto_web_view_page
    _touch_row('web view')
    wait_for_view('webViewPage')
  end
end
