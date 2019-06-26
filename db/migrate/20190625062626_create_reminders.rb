class CreateReminders < ActiveRecord::Migration[5.1]
  def change
    create_table :reminders do |t|
      t.integer :student_id
      t.integer :fee_id
      t.integer :balance_amount
      t.string :student_name
      t.string :father_email
      t.string :student_class
      t.string :student_division

      t.timestamps
    end
  end
end
