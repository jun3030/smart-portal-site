require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    @user = build(:user)
  end

  describe 'User CRUD' do
    describe 'ログイン前' do
      describe 'ユーザー新規登録' do
        context 'フォームの入力値が正常' do
          it "ユーザーの新規作成が成功" do
            # ユーザー新規登録画面へ遷移
            visit new_user_registration_path

            fill_in '名前', with: 'sample-user'
            fill_in 'ニックネーム', with: 'sample-user'
            find('#user_gender_male', visible: false).set('male')
            fill_in 'Eメール', with: 'sample-user@email.com'
            fill_in '住所', with: '東京都墨田区'
            fill_in 'パスワード', with: 'password'
            fill_in 'パスワード確認', with: 'password'


            fill_in 'email', with: 'test@email.com'

            fill_in 'password', with: 'password'
          end
        end
      end
    end

    describe 'ログイン後' do
    end

  end

end