class HomeController < ApplicationController
  def index
    @random_card = Card.reviews_today.random
  end

  def check_review
    card = params[:card]

    if card[:original_text] == card[:user_text]
      Card.update_review_date(card[:id])
    else
      flash[:correct_word] = card[:original_text]
    end

    redirect_to :root
  end
end
