class Privilege < ActiveRecord::Base

  has_many :employee_privileges
  has_many :employees, :through => :employee_privileges

  ADMIN       = 'admin'
  MEMBER      = 'member'
  VIEW        = 'view'

  PRIVILEGES = [
            {ADMIN  => 'Has the ability to do everything for the company account.'},
            {MEMBER => 'Has the ability to do modify their personal information but not company wide information.'},
            {VIEW   => 'Can view the company account.'} ]

  ADMIN_ID            = 1
  MEMBER_ID           = 2
  VIEW_ID             = 3

end
