require 'rails_helper'

describe Card do

  let (:card) { build(:card) }

  it "sets review_date = Date.today + 3 when review_date isn't provided" do
    expect(card.review_date).to eq Date.today + 3
  end

  it "is invalid when oringinal_text and translated_text are equal" do
    card.translated_text = "temerity"
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

  context "#perform_review" do
    it "returns false if given text isn't equal to original_text" do
      expect(card.perform_review("blah blah")).to be false
    end

    it "not change review_date if review was unsuccessful" do
      card.review_date = Date.today.prev_day

      card.perform_review("blah blah")

      expect(card.review_date).to eq Date.today.prev_day
    end

    it "returns true if given text is equal to original_text" do
      expect(card.perform_review("temerity")).to be true
    end

    it "increases review_date wnen review was successful" do
      card.review_date = Date.today.prev_day

      card.perform_review("temerity")

      expect(card.review_date).to eq Date.today + 3
    end
  end

  context "scope" do

    let (:user) { create(:user) }

    before(:each) do
      user.cards.create([
        { original_text: "a", translated_text: "aa", review_date: Date.today - 1 },
        { original_text: "b", translated_text: "bb", review_date: Date.today },
        { original_text: "c", translated_text: "cc", review_date: Date.today + 1}
      ])
    end

    it ".reviews_today returns cards scheduled for today" do
      cards = user.cards.reviews_today
      expect(cards.count{ |c| c.rewiev_date <= Date.today }).to eq 2
    end

    it ".random returns random card from scheduled for today" do
      cards = []
      10.times { cards << user.cards.reviews_today.random.take }

      a_cards_count = cards.count { |c| c.original_text == "a" }
      b_cards_count = cards.count { |c| c.original_text == "b" }

      expect(a_cards_count).to be_between(2, 8)
      expect(b_cards_count).to be_between(2, 8)
    end
  end
end
