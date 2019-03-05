class AddColumnsToOtherTables < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_admin, :boolean, default: false
    add_column :receipts, :receipt_date, :datetime
  end
end
