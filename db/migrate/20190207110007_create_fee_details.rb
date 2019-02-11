class CreateFeeDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :fee_details do |t|
      t.integer :fee_id
      t.date :fee_date
      t.string :description
      t.integer :student_id
      t.decimal :amount, precision: 12, scale: 3
      t.decimal :paid_amount, precision: 12, scale: 3
      t.decimal :balance_amount, precision: 12, scale: 3
      t.integer :payment_type
      t.string :receipt_no
      t.string :vno
      t.decimal :vat_percent, precision: 12, scale: 3
      t.datetime :paid_on

      t.timestamps
    end
  end
end
