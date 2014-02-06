require_relative '../br_page'

class CollectionPage < BrPage

  def navbar_title
    'Collection'
  end

  def mark
    'collection'
  end

  def go_back_to_home
    home = page(ScrollingHomePage)
    go_back_and_wait_for_view(home.mark())
    home
  end

end