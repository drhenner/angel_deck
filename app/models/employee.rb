class Employee < ActiveRecord::Base

  belongs_to :user
  belongs_to :company

  has_many :employee_privileges
  has_many :privileges, :through => :employee_privileges

  validates :user_id, :presence => true
  validates :company_id, :presence => true
end
