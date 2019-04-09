class AddColumnNotesToReceipt < ActiveRecord::Migration[5.1]
  def change
    add_column :receipts, :notes, :string
  end
end
