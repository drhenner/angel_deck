class CreatePrivileges < ActiveRecord::Migration
  def change
    create_table :privileges do |t|
      t.string :name,  :length => 40
      t.string :description
    end
    add_index :privileges, :name
  end
end
