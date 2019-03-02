class CreateTempDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :temp_details do |t|
      t.string :student_id
      t.decimal :paid_amount, precision: 12, scale: 3
      t.decimal :balance_amount, precision: 12, scale: 3

      t.timestamps
    end
  end
end
