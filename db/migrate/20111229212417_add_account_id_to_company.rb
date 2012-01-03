class AddAccountIdToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :account_id, :integer, :null => false
    add_column :companies, :company_type, :string, :length => 50

    add_index :companies, :account_id
    add_index :companies, :company_type
  end
end
