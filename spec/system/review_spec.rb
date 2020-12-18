require 'rails_helper'

RSpec.describe 'Review', type: :system do
  before do
    # レビューデータを作成
    # @user = User.create!(name: "test", email: "test@email.com", nickname: "test", password: "password", address: "japan-aichi-nagoya", gender: "male")
    StoreManager.create!(name: "store_manager", email: "store_manager@email.com", password: "password")
    @store = Store.create!(store_name: "sample1", adress: "京都府京都市中京区", store_phonenumber: "0909999999", store_manager_id: 1)
  end

  describe 'Review CRUD' do
    context "値がvalidの場合" do
      it "口コミが投稿される" do
        sign_in
        visit user_store_review_new_path(1)
      end
    end
  end

end

#   it "store_managerが新規登録される" do
    #     visit new_store_manager_registration_path
    #     fill_in '名前', with: 'sample-user'
    #     fill_in 'メールアドレス', with: 'sample-user@email.com'
    #     fill_in 'パスワード', with: 'password'
    #     fill_in 'パスワード確認', with: 'password'
    #     fill_in '店舗名', with: 'マッサージ店舗１'
    #     fill_in '住所', with: '京都府京都市'
    #     fill_in '電話番号', with: '09099999999'
    #     fill_in '店舗についての説明', with: 'マッサージのお店です。お越しください。'
    #     attach_file 'store_manager[store_attributes][store_images_attributes][0][store_image][]', "public/images/banner-1.jpg"
    #     attach_file 'store_manager[store_attributes][store_images_attributes][0][sm_image][]', "public/images//banner-2.jpg"
    #     fill_in 'プラン名', with: 'プラン１'
    #     fill_in 'プラン内容', with: '肩揉み'
    #     fill_in 'プラン時間', with: '60'
    #     fill_in 'プラン料金', with: '10000'
    #     attach_file 'store_manager[store_attributes][plans_attributes][0][plan_images_attributes][0][plan_image][]', "public/images/banner-1.jpg"
    #     click_button '登録する'
    #   end