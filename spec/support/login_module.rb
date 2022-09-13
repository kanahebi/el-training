module LoginModule
  def login(user)
    visit '/login'
    fill_in 'email', with: user.email
    fill_in 'password', with: 'password'
    click_button 'ログイン'
    find('.loginAlert')
  end
end
