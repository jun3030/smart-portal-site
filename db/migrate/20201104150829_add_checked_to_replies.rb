class AddCheckedToReplies < ActiveRecord::Migration[6.0]
  def change
    add_column :replies, :checked, :string
    add_column :replies, :reply_from, :string
  end
end
