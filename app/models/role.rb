class Role < ActiveRecord::Base

  has_many    :user_roles,                      :dependent => :destroy
  has_many    :users,         :through => :user_roles

  validates :name, :presence => true, :length => { :maximum => 55 }

  SUPER_ADMIN       = 'super_administrator'
  ADMIN             = 'administrator'
  VC                = 'venture_capitalist'
  ANGEL             = 'angel_investor'
  STARTUP_MEMBER    = 'startup_member'

  ROLES = [ SUPER_ADMIN,
            ADMIN,
            VC,
            ANGEL,
            STARTUP_MEMBER]

  NON_ADMIN_ROLES = [ VC,
                      ANGEL,
                      STARTUP_MEMBER]

  SUPER_ADMIN_ID      = 1
  ADMIN_ID            = 2
  VC_ID               = 3
  ANGEL_ID            = 4
  STARTUP_MEMBER_ID   = 5

  private

    def self.find_role_id(id)
      Rails.cache.fetch("role-#{id}") do #, :expires_in => 30.minutes
        self.find(id)
      end
    end

    def self.find_role_name(name)
      Rails.cache.fetch("role-#{name}") do #, :expires_in => 30.minutes
        self.find_by_name(name)
      end
    end
end
