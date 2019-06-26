class CreateReminderDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :reminder_details do |t|
      t.integer :reminder_id
      t.integer :fee_detail_id
      t.datetime :fee_date
      t.string :description
      t.decimal :amount
      t.decimal :paid_amount
      t.decimal :balance_amount

      t.timestamps
    end
  end
end
