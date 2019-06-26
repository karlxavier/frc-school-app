class AddColumnLastNotifiedToFee < ActiveRecord::Migration[5.1]
  def change
    add_column :fees, :last_notified, :datetime
  end
end
