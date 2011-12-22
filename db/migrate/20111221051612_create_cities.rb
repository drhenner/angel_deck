class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.integer :state_id,  :null => false
      t.string :name,       :null => false,  :length => 100
      t.decimal :latitude,      :precision => 10, :scale => 6, :null => false
      t.decimal :longitude,     :precision => 10, :scale => 6, :null => false
    end
    add_index :cities, :state_id
    add_index :cities, :name
  end
end
