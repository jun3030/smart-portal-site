class RemoveMessageStatusFromMessages < ActiveRecord::Migration[6.0]
  def change
    remove_column :messages, :message_status, :string
  end
end
