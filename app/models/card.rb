class Card < ActiveRecord::Base
  validates :original_text, :translated_text, presence: true
  validate :original_and_translated_texts_are_not_equal
  after_initialize :default_values

  def original_and_translated_texts_are_not_equal
    if mb_stripcase(original_text) == mb_stripcase(translated_text)
      errors.add(:original_text, "текст и перевод должны отличаться")
      errors.add(:translated_text, "перевод и оригинал должны отличаться")
    end
  end

  def default_values
    self.review_date ||= Date.today.next_day(3)
  end

  def mb_stripcase(str)
    str.mb_chars.strip.downcase.to_s
  end
end
