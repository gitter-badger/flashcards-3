require 'rails_helper'
require 'support/login_user'

describe "Review card" do
  let!(:card) { create(:card, review_date: Date.today) }

  before(:each) do
    login_user_post(card.user.email, attributes_for(:user)[:password])
  end

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
