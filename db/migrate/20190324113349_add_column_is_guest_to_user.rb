class AddColumnIsGuestToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_guest, :boolean, default: false
  end
end
