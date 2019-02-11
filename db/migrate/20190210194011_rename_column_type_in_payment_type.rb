class RenameColumnTypeInPaymentType < ActiveRecord::Migration[5.1]
  def change
    rename_column :payment_types, :type, :description
  end
end
