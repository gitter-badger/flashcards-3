require 'rails_helper'

describe Card do

  let (:card) { Card.new(original_text: "paucity", translated_text: "lack in amount or extent") }

  it "sets review_date = Date.today + 3 when review_date isn't provided" do
    expect(card.review_date).to eq Date.today + 3
  end

  it "is valid with a original_text and translated_text" do
    expect(card).to be_valid
  end

  it "is invalid when oringinal_text and translated_text are equal" do
    card.translated_text = "paucity"
    expect(card).not_to be_valid
  end

  it "is invalid when original_text and translated_text are equal but have different letters case and leading/trailing spaces" do
    card.original_text = " pauCity  "
    card.translated_text = "   paUciTy"

    expect(card).not_to be_valid
  end

  it "works properly with multibyte characters: should be invalid when original_text and translated_text are equal but have different letters case and leading/trailing spaces" do
    card.original_text = " ПразДник  "
    card.translated_text = "   ПРАЗДник"

    expect(card).not_to be_valid
  end

  context "perform_review method" do
    it "returns false if given text isn't equal to original_text" do
      expect(card.perform_review("blah blah")).to be false
    end

    it "not change review_date if review was unsuccessful" do
      card.review_date = Date.today.prev_day

      card.perform_review("blah blah")

      expect(card.review_date).to eq Date.today.prev_day
    end

    it "returns true if given text is equal to original_text" do
      expect(card.perform_review("paucity")).to be true
    end

    it "sets review_date to Date.today + 3 if review was successful" do
      card.review_date = Date.today.prev_day

      card.perform_review("paucity")

      expect(card.review_date).to eq Date.today + 3
    end
  end

  context "scope" do
    before(:each) do
      Card.create([
        {original_text: "a", translated_text: "b", review_date: Date.today-1},
        {original_text: "c", translated_text: "d", review_date: Date.today},
        {original_text: "e", translated_text: "f", review_date: Date.today+1}
      ])
    end

    it "reviews_today returns cards scheduled for today" do
      cards = Card.reviews_today
      expect(cards.count{ |c| c.rewiev_date <= Date.today }).to eq 2
    end

    it "random returns random card from scheduled for today" do
      cards = []
      10.times { cards << Card.reviews_today.random.take }

      expect(cards.count { |c| c.original_text == "a" }).to be_between(2, 8)
      expect(cards.count { |c| c.original_text == "c" }).to be_between(2, 8)
    end
  end
end
