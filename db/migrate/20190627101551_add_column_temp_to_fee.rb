class AddColumnTempToFee < ActiveRecord::Migration[5.1]
  def change
    add_column :fees, :temp, :boolean, default: true
  end
end
