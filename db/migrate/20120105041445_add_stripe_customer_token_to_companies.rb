class AddStripeCustomerTokenToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :stripe_customer_token, :string
  end
end
