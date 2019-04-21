class CreateRefunds < ActiveRecord::Migration[5.1]
  def change
    create_table :refunds do |t|
      t.integer :user_id
      t.integer :student_id
      t.integer :fee_id
      t.decimal :amount
      t.string :notes
      t.integer :status

      t.timestamps
    end
  end
end
