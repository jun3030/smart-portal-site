require 'rails_helper'

RSpec.describe 'Review', type: :system, js: true do
  before do
    store= build(:store)
    @store = Store.create!(store_name: store.store_name, adress: store.adress, store_phonenumber: store.store_phonenumber, store_manager_id: 1)
  end

  describe 'Review CRUD' do
    context "sign_in状態の場合" do
      before do
        sign_in
        visit user_store_review_new_path(@store.id)
      end
      context "値がvalidの場合" do
        let!(:before_count) { Review.all.count }
        it "口コミが投稿される" do
          find('#star').find("img[alt='5']").click
          fill_in 'タイトル', with: 'また利用したいです'
          fill_in 'レビュー内容', with: '丁寧に施術して頂きました。'
          click_on '口コミを投稿する'
          expect(current_path).to eq user_store_review_index_path(@store.id) # indexへ遷移したか確認
          expect(page).to have_content '口コミを投稿しました。' # メッセージが表示されたか確認
          expect(Review.all.count).not_to eq(before_count) # 口コミが作成されたか確認
        end
      end
      context "値がinvalidの場合" do
        it "口コミ投稿に失敗する" do
          find('#star').find("img[alt='5']").click
          fill_in 'タイトル', with: 'また利用したいです'
          fill_in 'レビュー内容', with: ''
          click_on '口コミを投稿する'
          expect(page).to have_content '口コミが投稿できませんでした。投稿するには全ての項目を埋めて下さい。' # エラーメッセージが出ているか確認/newページに遷移したか確認
          expect(page).to have_field 'タイトル', with: 'また利用したいです' # 入力内容が保持されているか確認
          expect { click_on '口コミを投稿する' }.not_to change(Review, :count) # 口コミの作成に失敗したか確認
        end
      end
      context "口コミが投稿された場合" do
        before do
          find('#star').find("img[alt='5']").click
          fill_in 'タイトル', with: 'また利用したいです'
          fill_in 'レビュー内容', with: '丁寧に施術して頂きました。'
          click_on '口コミを投稿する'
          expect(current_path).to eq user_store_review_index_path(@store.id) # indexへ遷移したか確認
        end
        it "showページへ遷移できること" do
          click_on '丁寧に施術して頂きました。'
          expect(page).to have_content '編集' # 編集ボタンがあることを確認
          expect(page).to have_content '削除' # 編集ボタンがあることを確認
        end
        context "editページへ遷移した場合" do
          context "値がvalidの場合" do
            it "口コミを更新できること" do
              click_on '丁寧に施術して頂きました。'
              click_on '編集'
              find('#star').find("img[alt='1']").click
              fill_in 'タイトル', with: '更新'
              fill_in 'レビュー内容', with: '体が楽になりました！'
              click_on '口コミを編集する'
              expect(current_path).to eq user_store_review_show_path(@store.id, Review.first.id)
              expect(page).to have_content '口コミを更新しました。'
            end
          end
          context "値がinvalidの場合" do
            it "口コミの更新に失敗すること" do
              click_on '丁寧に施術して頂きました。'
              click_on '編集'
              find('#star').find("img[alt='1']").click
              fill_in 'タイトル', with: '更新失敗'
              fill_in 'レビュー内容', with: ''
              click_on '口コミを編集する'
              expect(page).to have_content '口コミが更新されませんでした。更新するには全ての項目を記入して下さい。' # エラーメッセージが出ているか確認/editページに遷移したか確認
              expect(page).to have_field 'タイトル', with: '更新失敗' # 入力内容が保持されているか確認
              expect(page).to have_field 'レビュー内容', with: '' # 入力内容が保持されているか確認
            end
          end
          context "削除を押した場合" do
            let!(:before_count) { Review.all.count }
            it "口コミを削除できること" do
              click_on '丁寧に施術して頂きました。'
              click_on '削除'
              expect(page.driver.browser.switch_to.alert.text).to eq "口コミを本当に削除しますか？" # アラートメッセージの確認
              page.driver.browser.switch_to.alert.dismiss
              expect{
                  expect(page.accept_confirm).to eq "口コミを本当に削除しますか？"
                  expect(page).to have_content "口コミを削除しました。"
                  }
            end
          end
        end
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