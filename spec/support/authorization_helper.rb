# encoding: UTF-8

def register_user(user)
  visit root_path
  click_link 'Зарегистрироваться'

  fill_in 'Адрес электронной почты', with: user[:email]
  fill_in 'Пароль',                  with: user[:password]
  fill_in 'Подтверждение пароля',    with: user[:password]
  click_button 'Sign up' # FIXME: Перевести
end

def sign_in_user(user)
    user.password.should_not be_empty
    visit root_path
    click_link 'Войти'

    fill_in 'Адрес электронной почты', with: user.email
    fill_in 'Пароль',                  with: user.password
    click_button 'Sign in'

    page.should have_text 'Вы успешно вошли в свою панель управления.'
end
