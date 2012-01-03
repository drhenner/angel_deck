class AddUserNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_name, :string, :length => 40, :null => false
    add_index :users, :user_name
  end
end
