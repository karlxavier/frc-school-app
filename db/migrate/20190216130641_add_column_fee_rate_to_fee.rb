class AddColumnFeeRateToFee < ActiveRecord::Migration[5.1]
  def change
    add_column :fees, :fee_rate, :decimal, precision: 12, scale: 3
  end
end
