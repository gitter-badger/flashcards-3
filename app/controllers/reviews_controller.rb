class ReviewsController < ApplicationController
  def new
    @review = Card.reviews_today.random.take
  end

  def create
    review = params.permit(:user_translation, :card_id)

    @card = Card.find(review[:card_id])

    if @card.perform_review(review)
      flash[:correct_review] = true
    else
      flash[:correct_answer] = @card[:original_text]
    end

    redirect_to new_review_path
  end

end
