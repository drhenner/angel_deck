class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.text :brief_description
      t.text :description
      t.text :description_markup
      t.integer :city_id

      t.timestamps
    end

    add_index :companies, :name
    add_index :companies, :city_id
  end
end
