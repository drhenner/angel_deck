class CreateEmployeePrivileges < ActiveRecord::Migration
  def change
    create_table :employee_privileges do |t|
      t.integer :employee_id,  :null => false
      t.integer :privilege_id,  :null => false

      t.datetime :created_at
    end
    add_index :employee_privileges, :employee_id
    add_index :employee_privileges, :privilege_id
  end
end
