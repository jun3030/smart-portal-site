class AddReplyToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :reply, :string
  end
end
