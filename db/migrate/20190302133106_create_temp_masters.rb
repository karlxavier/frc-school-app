class CreateTempMasters < ActiveRecord::Migration[5.1]
  def change
    create_table :temp_masters do |t|
      t.string :student_id
      t.string :month_year
      t.decimal :amount

      t.timestamps
    end
  end
end
