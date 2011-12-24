class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :unique_identifier, :limit => 40, :null => false
      t.string :website
      t.string :blog
      t.text :brief_description
      t.integer :city_id

      t.timestamps
    end

    add_index :companies, :name
    add_index :companies, :unique_identifier, :unique => true
    add_index :companies, :city_id
  end
end
