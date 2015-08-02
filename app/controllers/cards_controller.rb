class CardsController < ApplicationController
  def index
    @cards = Card.all.order(:id)
  end

  def new
    @card = Card.new(review_date: Date.today.next_day(3))
  end

  def create
    @card = Card.new(card_params)

    if @card.save
      redirect_to cards_path
    else
      render 'new'
    end
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])

    if @card.update(card_params)
      redirect_to cards_path
    else
      render 'edit'
    end
  end

  def destroy
    Card.find(params[:id]).destroy

    redirect_to cards_path
  end

  private
  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end
end
