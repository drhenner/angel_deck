class EmployeePrivilege < ActiveRecord::Base

  belongs_to :employee
  belongs_to :privilege


  validates :privilege_id, :presence => true
  validates :employee_id, :presence => true
end
