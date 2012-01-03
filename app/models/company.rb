class Company < ActiveRecord::Base
  has_friendly_id :unique_identifier, :use_slug => false

  belongs_to :account
  belongs_to :city
  belongs_to :maintainer, :class_name => 'User'
  has_many :employees
  has_many :users, :through => :employees
  has_many :pages, :as => :pageable

  validates :name, :presence => true, :length => { :maximum => 50 }#, :uniqueness => {:scope => :city_id}
  validates :account_id, :presence => true
  validates :company_type, :presence => true, :length => { :maximum => 50 }
  validates :city_id, :presence => true
  validates :maintainer_id, :presence => true
  validates :brief_description, :presence => true
  validates :unique_identifier, :presence => true, :length => { :minimum => 4, :maximum => 40 }, :uniqueness => true

  COMPANY_TYPES = ['Angel Fund', 'Venture Capitalist', 'Private', 'Non-Investment']

  def make_owner(user, title = 'Owner' )
    owner = self.employees.new(:user => user, :title => title, :status => 'active' )
    owner.privilege_ids = Privilege.select(:id).all.map(&:id)
    owner.save!
    if maintainer_id != user.id
      self.maintainer_id = user.id
      save
    end
  end

  def find_employee(user_id)
    Employee.includes(:privileges).where(:company_id => id, :user_id => user_id).first
  end

  def user_is_admin?(user)
    (maintainer.id == user.id) || (find_employee(user.id).try(:admin?))
  end
end
