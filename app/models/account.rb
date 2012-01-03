# == Schema Information
#
# Table name: accounts
#
#  id             :integer(4)      not null, primary key
#  name           :string(255)     not null
#  account_type   :string(255)     not null
#  monthly_charge :decimal(8, 2)   default(0.0), not null
#  active         :boolean(1)      default(TRUE), not null
#  created_at     :datetime
#  updated_at     :datetime
#

class Account < ActiveRecord::Base

  FREE              = 'Free'
  PRIVATE           = 'Private'
  SEMI_PRIVATE      = 'Semi-Private'
  SELECTIVE         = 'Selective'
  INVESTOR          = 'Investor'
  PREMIUM_INVESTOR  = 'Premium Investor'

  FREE_ID               = 1
  SEMI_PRIVATE_ID       = 2
  PRIVATE_ID            = 3
  SELECTIVE_ID          = 4
  INVESTOR_ID           = 5
  PREMIUM_INVESTOR_ID   = 6

  TYPES = {
      FREE              => {:id => FREE_ID,             :name => FREE,            :account_type => FREE,            :monthly_charge => 0.00, :description => 'Free account for business Owners'},
      SEMI_PRIVATE      => {:id => SEMI_PRIVATE_ID,     :name => SEMI_PRIVATE,    :account_type => SEMI_PRIVATE,    :monthly_charge => 8.00, :description => 'Hide your Company from the general public but allow confirmed Investors to view the company.'},
      PRIVATE           => {:id => PRIVATE_ID,          :name => PRIVATE,         :account_type => PRIVATE,         :monthly_charge => 14.00, :description => 'Hide your Company from everyone except employees in the company.'},
      SELECTIVE         => {:id => SELECTIVE_ID,        :name => SELECTIVE,       :account_type => SELECTIVE,       :monthly_charge => 25.00, :description => 'Only allow employees and specifically selected members to view the company information.'},
      INVESTOR          => {:id => INVESTOR_ID,         :name => INVESTOR,        :account_type => INVESTOR,        :monthly_charge => 0.00,  :description => 'Allow Investors to have a basic account to contact public accounts.'},
      PREMIUM_INVESTOR  => {:id => PREMIUM_INVESTOR_ID, :name => PREMIUM_INVESTOR,:account_type => PREMIUM_INVESTOR,:monthly_charge => 100.00,:description => 'Allow Investors to view semi-private accounts.  Also the investor can create there own homepage.'}
  }


  FREE_ACCOUNT_IDS    = [ FREE_ID, INVESTOR_ID ]

  validates :name,            :presence => true,       :length => { :maximum => 255 }
  validates :account_type,    :presence => true,       :length => { :maximum => 255 }
  validates :description,    :presence => true,       :length => { :maximum => 255 }
  validates :monthly_charge,  :presence => true

  def name_with_price
    [name, monthly_charge].join(', $')
  end

end
