class Employee < ActiveRecord::Base

  belongs_to :user_id
  belongs_to :company_id

  has_many :employee_privileges
  has_many :privileges, :through => :employee_privileges

  validates :user_id, :presence => true
  validates :company_id, :presence => true
end
