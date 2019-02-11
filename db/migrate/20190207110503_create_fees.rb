class CreateFees < ActiveRecord::Migration[5.1]
  def change
    create_table :fees do |t|
      t.string :student_id
      t.decimal :total_amount, precision: 12, scale: 3
      t.decimal :paid_amount, precision: 12, scale: 3
      t.decimal :balance_amount, precision: 12, scale: 3
      t.datetime :last_payment

      t.timestamps
    end
  end
end
