class AddColumnChargeableToFeeDetail < ActiveRecord::Migration[5.1]
  def change
    add_column :fee_details, :chargeable, :boolean, default: true
  end
end
