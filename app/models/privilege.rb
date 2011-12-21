class Privilege < ActiveRecord::Base

  has_many :employee_privileges
  has_many :employees, :through => :employee_privileges

  ADMIN       = 'admin'
  VIEW        = 'view'

  PRIVILEGES = [
            ADMIN,
            VIEW ]

  ADMIN_ID            = 1
  VIEW_ID             = 2

end
