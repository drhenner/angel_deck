class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string  :name, :null => false
      t.integer :pageable_id, :null => false
      t.string :pageable_type, :null => false
      t.string :page_type
      t.text :description, :null => false
      t.text :description_markup, :null => false

      t.timestamps
    end
    add_index :pages, :pageable_id
    #add_index :pages, :page_type
  end
end
