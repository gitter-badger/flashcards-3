class ReviewsController < ApplicationController
  def new
    @review = Card.reviews_today.random.take
  end

  def create
    @card = Card.find(review_params[:card_id])

    if @card.perform_review(review_params[:user_translation])
      flash[:correct_review] = true
    else
      flash[:correct_answer] = @card[:original_text]
    end

    redirect_to new_review_path
  end

  private

  def review_params
    params.permit(:user_translation, :card_id)
  end
end
