class Company < ActiveRecord::Base

  has_many :employees
  has_many :users, :through => :employees

end
