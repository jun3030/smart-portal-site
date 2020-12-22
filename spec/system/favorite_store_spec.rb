require 'rails_helper'

RSpec.describe 'FavoriteStore CRUD', type: :system, js: true do
  before do
    StoreManager.create!(email: "sample1@email.com", name: "sample1", password: "password", order_plan: 1)
    Store.create!(store_name: "sample1の店舗", adress: "京都府京都市中京区", store_phonenumber: "09012345678", store_description: "sample2の店舗sample2の店舗sample2の店舗",
                store_manager_id: 1, calendar_id: 1, calendar_secret_id: 1, calendar_status: "released")
    Masseur.create!(masseur_name: "sample1", email: "sample1@email.com", adress: "京都府京都市中京区", password: "password", password_confirmation: "password", store_id: 1)
    Plan.create!(plan_name: "プラン1", plan_content: "PCやスマートフォンを使ったり鞄を持ったりと、日常の疲れが溜まりやすい肘から下をもみほぐす【ハンドリフレ】。肩や目が疲れやすい方に、頭から首にかけてもみほぐす【クイックヘッド】。ストレスが溜まりやすい方や頭からスッキリとリラックスしたい方にオススメ。",
                plan_time: 30, plan_price: 5000, store_id: 1)
  end

  describe 'CRUD機能' do
    context "sign_in状態の場合" do
      before do
        sign_in
      end
      context "「お気に入り店舗に追加する」ボタンをクリックした場合" do
        before do
          visit details_path(Store.first.id)
          expect { click_on 'お気に入り店舗に追加する' }.to change { User.first.favorite_stores.count }.by(1)
        end
        it "お気に入り店舗に登録されること" do
          expect(page).to have_content 'お気に入り店舗に登録しました。'
        end
        context "indexページにてXボタンを押した場合" do
          it "お気に入りリストから削除されること" do
            visit user_favorite_stores_index_path(User.first.id)
            find('#cross-image').click
            expect(page).to have_content 'sample1の店舗をお気に入りの店舗から削除しました。'
          end
        end
      end
    end
    context "sign_out状態の場合" do
      context "「お気に入り店舗に追加する」ボタンをクリックした場合" do
        it "お気に入り店舗登録に失敗すること" do
            visit details_path(Store.first.id)
            click_on 'お気に入り店舗に追加する'
            expect(FavoriteStore.all.count).to eq 0
            expect(page).to have_content 'アカウントをお持ちの方はログインして下さい。'
        end
      end
    end
  end
end

