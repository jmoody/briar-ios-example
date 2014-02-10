require 'calabash-cucumber/core'
require 'briar/briar_core'

module Briar
  class Model
    include Calabash::Cucumber::Core
    include Briar::Core

    def location_of_food(food)
      allowed = ['hamburger', 'risotto', 'cake']
      case food
        when 'hamburger'
          {:item => 1, :section => 2, :id => 'hamburger.jpg'}
        when 'risotto'
          {:item => 1, :section => 3, :id => 'mushroom_risotto.jpg'}
        when 'cake'
          {:item => 0, :section => 0, :id => 'angry_birds_cake.jpg'}
        else
          raise "expected '#{food}' to be one of '#{allowed}'"
      end

    end

  end

  def briar_model
    Model.new
  end

end

World(Briar)