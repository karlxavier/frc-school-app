class CreateSchoolYears < ActiveRecord::Migration[5.1]
  def change
    create_table :school_years do |t|
      t.string :description

      t.timestamps
    end
    add_column :fees, :school_year_id, :integer
  end
end
