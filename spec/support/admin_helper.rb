# encoding: UTF-8
def become_user(user)
  visit users_path
  click_link 'Become user'
end

def new_ban_user(user)
  visit users_path
  click_link 'Ban user'
end

def ban_user(user, comment)
  new_ban_user(user)

  fill_in 'Comment', with: comment

  click_button 'Create Admin comment'
end
