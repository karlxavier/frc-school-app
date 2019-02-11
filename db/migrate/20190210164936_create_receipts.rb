class CreateReceipts < ActiveRecord::Migration[5.1]
  def change
    create_table :receipts do |t|
      t.integer :fee_id
      t.decimal :amount
      t.integer :receipt_no

      t.timestamps
    end
  end
end
