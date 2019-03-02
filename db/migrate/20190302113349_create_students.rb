class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :code
      t.string :name
      t.string :parent_name
      t.string :status
      t.string :gender
      t.string :nationality
      t.string :birthdate
      t.string :roll_no
      t.string :class
      t.string :division
      t.string :address1
      t.string :address2
      t.string :father_mobile
      t.string :father_email
      t.string :mother_name
      t.string :mother_mobile
      t.string :bus_mode
      t.string :bus_time_in
      t.string :bus_time_out
      t.string :religion
      t.string :joining_date

      t.timestamps
    end
  end
end
