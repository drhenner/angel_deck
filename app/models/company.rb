class Company < ActiveRecord::Base
  has_friendly_id :unique_identifier, :use_slug => false

  belongs_to :city
  has_many :employees
  has_many :users, :through => :employees
  has_many :pages, :as => :pageable

  validates :name, :presence => true, :length => { :maximum => 50 }#, :uniqueness => {:scope => :city_id}
  validates :city_id, :presence => true
  validates :brief_description, :presence => true
  validates :unique_identifier, :presence => true, :length => { :minimum => 4, :maximum => 40 }, :uniqueness => true


  def make_owner(user, title = 'Owner' )
    owner = self.employees.new(:user => user, :title => title, :status => 'active' )
    owner.privilege_ids = Privilege.select(:id).all.map(&:id)
    owner.save!
  end

  def find_employee(user_id)
    Employee.includes(:privileges).where(:company_id => id, :user_id => user_id).first
  end
end
