# encoding: UTF-8
def become_user(user)
  visit users_path
  click_link 'Become user'
end
