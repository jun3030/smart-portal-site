class CreateFavoriteStores < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_stores do |t|
      t.references :user, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
