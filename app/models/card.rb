class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validate :original_and_translated_texts_are_not_equal

  def original_and_translated_texts_are_not_equal
    if original_text.mb_chars.strip.downcase == translated_text.mb_chars.strip.downcase
      errors.add(:original_text, "текст и перевод должны отличаться")
      errors.add(:translated_text, "перевод и оригинал должны отличаться")
    end
  end
end
