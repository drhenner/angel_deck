class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.integer :company_id,  :null => false
      t.integer :user_id,  :null => false
      t.string :title,  :length => 150
      t.string :status,  :length => 40

      t.timestamps
    end
    add_index :employees, :company_id
    add_index :employees, :user_id
  end
end
