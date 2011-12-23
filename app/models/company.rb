class Company < ActiveRecord::Base

  has_many :employees
  has_many :users, :through => :employees
  has_many :pages, :as => :pageable

  validates :name, :presence => true, :length => { :maximum => 50 }
  validates :city_id, :presence => true
  validates :brief_description, :presence => true
end
