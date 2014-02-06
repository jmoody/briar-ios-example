require 'briar/page/briar_page'

class BrPage < BriarPage
  def navbar_title
    raise 'subclasses must implement'
  end

  def expect_navbar_title
    title = self.navbar_title
    should_see_navbar_with_title title
  end

  def random_bool
    ['true', 'false'].sample()
  end
end