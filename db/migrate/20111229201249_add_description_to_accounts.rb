class AddDescriptionToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :description, :string
  end
end
