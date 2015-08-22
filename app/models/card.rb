class Card < ActiveRecord::Base
  belongs_to :user

  validates :user, :original_text, :translated_text, :review_date, presence: true
  validate :original_and_translated_texts_are_not_equal

  after_initialize :default_values

  scope :reviews_today, -> { where('review_date <= ?', Date.today) }
  scope :random, -> { offset(rand(Card.reviews_today.count)) }

  def perform_review(user_translation)
    if mb_stripcase(original_text) == mb_stripcase(user_translation)
      update(review_date: Date.today + 3)
      true
    else
      false
    end
  end

  def original_and_translated_texts_are_not_equal
    if mb_stripcase(original_text) == mb_stripcase(translated_text)
      errors.add(:original_text, "текст и перевод должны отличаться")
      errors.add(:translated_text, "перевод и оригинал должны отличаться")
    end
  end

  def default_values
    self.review_date ||= Date.today + 3
  end

  def mb_stripcase(str)
    str.to_s.mb_chars.strip.downcase.to_s
  end
end
