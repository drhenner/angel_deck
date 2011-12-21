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

  FREE  = 'Free'
  PRIVATE  = 'Private'
  TYPES = {FREE => 0.00, PRIVATE => 12.00 }

  FREE_ID             = 1
  FREE_ACCOUNT_IDS    = [ FREE_ID ]

  PRIVATE_ID          = 2

  validates :name,            :presence => true,       :length => { :maximum => 255 }
  validates :account_type,    :presence => true,       :length => { :maximum => 255 }
  validates :monthly_charge,  :presence => true


end
