class CreateEmployeePrivileges < ActiveRecord::Migration
  def change
    create_table :employee_privileges do |t|
      t.integer :employee_id
      t.integer :privilege_id

      t.timestamps
    end
  end
end
