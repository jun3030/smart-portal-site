class AddCheckedToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :checked, :boolean
  end
end
