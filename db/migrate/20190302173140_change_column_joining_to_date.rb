class ChangeColumnJoiningToDate < ActiveRecord::Migration[5.1]
  def change
    # change_column :students, :joining_date, 'datetime USING CAST(joining_date AS datetime)'
    remove_column :students, :joining_date
    add_column :students, :joining_date, :datetime
  end
end
