class ReviewsController < ApplicationController
  def new
    @review = Card.reviews_today.random

    @review.original_text = nil
  end

  def create
    review = params[:card]

    @card = Card.find(review[:id])

    if @card.update_review(review)
      flash[:correct_review] = true
    else
      flash[:correct_answer] = @card[:original_text]
    end

    redirect_to new_review_path
  end
end
