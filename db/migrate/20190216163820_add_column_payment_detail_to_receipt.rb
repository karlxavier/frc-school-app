class AddColumnPaymentDetailToReceipt < ActiveRecord::Migration[5.1]
  def change
    add_column :receipts, :payment_reference, :string
  end
end
