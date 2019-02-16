class AddColumnPaidToFee < ActiveRecord::Migration[5.1]
  def change
    add_column :fees, :paid, :boolean, default: false
  end
end
