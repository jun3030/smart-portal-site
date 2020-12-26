require 'rails_helper'

RSpec.describe 'Message', type: :system do
  before do
    User.create!(name: "tester1", email: "tester1@email.com", password: "password")
    StoreManager.create!(name: "sample1", email: "sample1@email.com", password: "password", order_plan: 1)
    @store = Store.create!(store_name: "sample1の店舗", adress: "京都府京都市中京区", store_phonenumber: "09012345678",
                          store_description: "sample1の店舗sample1の店舗sample1の店舗",　store_manager_id: 1, calendar_id: 1, calendar_secret_id: 1, calendar_status: "released")
  end

  describe 'Message機能' do
    context "sign_in状態の場合" do
      before do
        sign_in
        visit details_path(@store.id)
        expect(page).to have_content '店舗への問い合わせはこちら' # メッセージボタンが存在することを確認
        visit store_message_new_path(@store.id)
      end
      context "値がvalidの場合" do
        it "メッセージが送信される" do
          let!(:before_count) { Message.all.count }
          fill_in 'タイトル', with: 'プランについて'
          fill_in '内容', with: 'もう少し長い施術時間のコースはありますか？'
          click_on 'メッセージを送信する'
          find('#store_id', visible: false).set('@store.id')　# hidden
          find('#user_id', visible: false).set('current_user.id') # hidden
          find('#checked', visible: false).set('未読') # hidden
          expect(current_path).to eq details_path(@store.id) # 店舗詳細ページへ遷移したか確認
          expect(page).to have_content 'メッセージを送信しました。' # メッセージが表示されたか確認
          expect(Message.all.count).not_to eq(before_count) # 口コミが作成されたか確認
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
