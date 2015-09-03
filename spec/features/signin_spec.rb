require 'rails_helper'

describe 'Authentication' do
  let! (:user) { create(:user) }

  context 'existing user' do
    before(:each) do
      visit root_path
      click_link 'Вход'
      fill_in 'Email', with: user.email
      fill_in 'Пароль', with: attributes_for(:user)[:password]
      click_button 'Войти'
    end

    it 'can sign in' do
      expect(page).to have_content('Успешный вход')
    end

    it 'can sign out' do
      click_link 'Выход'

      expect(page).to have_content('Вход')
    end

    it 'can change his email and password' do
      click_link 'Профиль'
      fill_in 'Email', with: 'new@test.ru'
      fill_in 'Пароль', with: 'qwerty'
      fill_in 'Подтверждение пароля', with: 'qwerty'
      click_button 'Сохранить изменения'

      expect(page).to have_content('Профиль был обновлен')
    end
  end

  it 'new user can register and should be signed in right after' do
    visit root_path
    click_link 'Регистрация'
    fill_in 'Email', with: 'user@space.ru'
    fill_in 'Пароль', with: 'sekret'
    fill_in 'Подтверждение пароля', with: 'sekret'
    click_button 'Зарегистрировать'

    expect(page).to have_content('Пользователь успешно создан')
    expect(page).to have_content('Выход')
  end
end
