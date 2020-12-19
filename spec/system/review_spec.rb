require 'rails_helper'

RSpec.describe 'Review', type: :system, js: true do

  before do
    store= build(:store)
    @store = Store.create!(store_name: store.store_name, adress: store.adress, store_phonenumber: store.store_phonenumber, store_manager_id: 1)
  end

  describe 'Review CRUD' do
    context "値がvalidの場合" do
      it "口コミが投稿される" do
        sign_in
        visit user_store_review_new_path(@store.id)
        find('#star').find("img[alt='5']").click
        fill_in 'タイトル', with: 'また利用したいです'
        fill_in 'レビュー内容', with: '丁寧に施術して頂きました。'
        click_on '口コミを投稿する'
        expect(current_path).to eq user_store_review_index_path(@store.id) # user/review indexへ遷移すること
        expect(page).to have_content '口コミを投稿しました。'
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