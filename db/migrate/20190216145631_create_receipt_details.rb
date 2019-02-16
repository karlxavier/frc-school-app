class CreateReceiptDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :receipt_details do |t|
      t.integer :receipt_id
      t.decimal :amount, precision: 12, scale: 3
      t.integer :fee_detail_id

      t.timestamps
    end
  end
end
