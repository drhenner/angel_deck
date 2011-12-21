class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.integer :company_id
      t.integer :user_id
      t.string :title
      t.string :status

      t.timestamps
    end
  end
end
