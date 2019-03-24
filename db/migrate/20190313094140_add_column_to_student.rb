class AddColumnToStudent < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :is_active, :boolean, default: true
  end
end
