class AddColumnUserIdToReceipt < ActiveRecord::Migration[5.1]
  def change
    add_column :receipts, :user_id, :integer
  end
end
