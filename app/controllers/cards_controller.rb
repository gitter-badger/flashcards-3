class CardsController < ApplicationController
  def index
    @cards = Card.all.order(:id)
  end
end
