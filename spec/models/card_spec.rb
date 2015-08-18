require 'rails_helper'

RSpec.describe Card, type: :model do
  before :each do
    @card = Card.new(
      original_text: "paucity",
      translated_text: "lack in amount or extent"
    )
  end

  it "is invalid without original_text" do
    @card.original_text = nil
    @card.validate
    expect(@card.errors[:original_text]).to include("can't be blank")
  end

  it "is invalid without translated_text" do
    @card.translated_text = nil
    @card.validate
    expect(@card.errors[:translated_text]).to include("can't be blank")
  end

  it "is invalid when review_date is nil" do
    @card.review_date = nil
    @card.validate
    expect(@card.errors[:review_date]).to include("can't be blank")
  end

  it "sets review_date = Date.today + 3 when review_date isn't provided" do
    expect(@card.review_date).to eq Date.today + 3
  end

  it "is valid with a original_text and translated_text" do
    expect(@card).to be_valid
  end

  it "is invalid when oringinal_text and translated_text are equal" do
    @card.translated_text = "paucity"
    expect(@card).not_to be_valid
  end

  it "is invalid when original_text and translated_text are equal but have different letters case and leading/trailing spaces" do
    @card.original_text = " pauCity  "
    @card.translated_text = "   paUciTy"

    expect(@card).not_to be_valid
  end

  it "works properly with multibyte characters: should be invalid when original_text and translated_text are equal but have different letters case and leading/trailing spaces" do
    @card.original_text = " ПразДник  "
    @card.translated_text = "   ПРАЗДник"

    expect(@card).not_to be_valid
  end

  context "perform_review method" do
    it "returns false if given text isn't equal to original_text" do
      expect(@card.perform_review("blah blah")).to be false
    end

    it "not change review_date if review was unsuccessful" do
      @card.review_date = Date.today.prev_day

      @card.perform_review("blah blah")

      expect(@card.review_date).to eq Date.today.prev_day
    end

    it "returns true if given text is equal to original_text" do
      expect(@card.perform_review("paucity")).to be true
    end

    it "sets review_date to Date.today + 3 if review was successful" do
      @card.review_date = Date.today.prev_day

      @card.perform_review("paucity")

      expect(@card.review_date).to eq Date.today + 3
    end
  end
end
