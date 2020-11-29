class ChangeDatatypecheckedOfMessages < ActiveRecord::Migration[6.0]
  def change
    change_column :messages, :checked, :string
  end
end
