module SignInModule
  def sign_in
    visit new_user_registration_path
    fill_in '名前', with: 'sample-user'
    fill_in 'ニックネーム', with: 'sample-user'
    find('#user_gender_male', visible: false).set('male')
    fill_in 'Eメール', with: 'sample-user@email.com'
    fill_in '住所', with: '東京都墨田区'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    click_button '新規会員登録'
  end
end