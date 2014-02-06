require_relative 'br_page'

class HomePage < BrPage

  def tabbar_item_mark
    raise 'subclasses must implement'
  end

  def navigate_to(current_page=nil)
    return if page_visible?

    unless tabbar_visible?
      raise 'expected tabbar to be visible'
    end

    tab_mark = tabbar_item_mark
    touch_tabbar_item tab_mark, mark()
    self
  end

end
