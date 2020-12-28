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
        visit details_path(@store.id) # 店舗詳細ページへ
        expect(page).to have_content '店舗への問い合わせはこちら' # メッセージボタンが存在することを確認
        visit store_message_new_path(@store.id) # メッセージ作成ページへ
      end
      context "値がvalidの場合" do
        it "メッセージが送信される" do
          let!(:before_count) { Message.all.count }
          fill_in 'タイトル', with: 'プランについて'
          fill_in '内容', with: 'もう少し長い施術時間のコースはありますか？'
          click_on 'メッセージを送信する'
          find('#store_id', visible: false).set('@store.id')　# hidden_field
          find('#user_id', visible: false).set('current_user.id') # hidden_field
          find('#checked', visible: false).set('未読') # hidden_field
          expect(current_path).to eq details_path(@store.id) # 店舗詳細ページへ遷移したか確認
          expect(page).to have_content 'メッセージを送信しました。' # メッセージが表示されたか確認
          expect(Message.all.count).not_to eq(before_count) # メッセージが作成されたか確認
        end
      end
      context "値がinvalidの場合" do
        it "メッセージ送信に失敗する" do
          fill_in 'タイトル', with: 'プランについて'
          fill_in '内容', with: ''
          click_on 'メッセージを送信する'
          expect(page).to have_content '本文を入力してください' # エラーメッセージが出ているか確認
          expect(current_path).to eq store_message_new_path(@store.id) # message_newページに遷移したか確認
          expect(page).to have_field 'タイトル', with: 'プランについて' # 入力内容が保持されているか確認
          expect { click_on 'メッセージを送信する' }.not_to change(Message, :count) # メッセージの作成に失敗したか確認
        end
      end
      context "メッセージが作成された場合" do
        before do
          fill_in 'タイトル', with: 'プランについて'
          fill_in '内容', with: 'もう少し長い施術時間のコースはありますか？'
          click_on 'メッセージを送信する'
          find('#store_id', visible: false).set('@store.id')　# hidden_field
          find('#user_id', visible: false).set('current_user.id') # hidden_field
          find('#checked', visible: false).set('未読') # hidden_field
        end
        it "message_showページへ遷移できること" do
          click_on 'プランについて'
          expect(page).to have_content '削除' # 削除ボタンがあることを確認
        end
        context "削除を押した場合" do
          let!(:before_count) { Message.all.count }
          it "メッセージを削除できること" do
            click_on '削除'
            expect(page.driver.browser.switch_to.alert.text).to eq "削除してよろしいですか？" # アラートメッセージの確認
            page.driver.browser.switch_to.alert.dismiss
            expect{
                expect(page).to have_content "口コミを削除しました。"
                }
          end
        end
      end
    end
  end
end
