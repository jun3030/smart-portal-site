class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.string :plan_name
      t.integer :plan_price
      t.references :store

      t.timestamps
    end
  end
end
