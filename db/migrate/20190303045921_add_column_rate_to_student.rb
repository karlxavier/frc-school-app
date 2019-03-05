class AddColumnRateToStudent < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :rate, :decimal, precision: 12, scale: 3
  end
end
