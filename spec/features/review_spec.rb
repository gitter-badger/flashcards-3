require 'rails_helper'

describe "Review card" do
  let!(:card) { create(:card, review_date: Date.today) }

  it "is successful" do
    visit root_path
    expect(page).to have_content("Пересмотр сегодня")
    fill_in "Введите оригинальное слово", with: card.original_text
    click_button "Следущее слово"

    expect(page).to have_content("Правильно!")
  end

  it "is unsuccessful" do
    visit root_path
    expect(page).to have_content("Пересмотр сегодня")
    click_button "Следущее слово"

    expect(page).to have_content("Неверно!")
  end
end

