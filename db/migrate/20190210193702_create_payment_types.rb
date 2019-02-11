class CreatePaymentTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_types do |t|
      t.string :type

      t.timestamps
    end

    add_column :receipts, :payment_type_id, :integer
  end
end
