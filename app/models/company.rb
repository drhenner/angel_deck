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
  validates :company_type, :length => { :maximum => 50 }
  validates :city_id, :presence => true
  validates :maintainer_id, :presence => true
  #validates :brief_description, :presence => true
  validates :unique_identifier, :presence => true, :length => { :minimum => 4, :maximum => 40 }, :uniqueness => true

  validate :has_stripe_token

# :city_id=>["can't be blank"],
# :brief_description=>["can't be blank"], :base=>["There is a problem with your credit card."]}


  attr_accessor :stripe_card_token

  COMPANY_TYPES = ['Angel Fund', 'Venture Capitalist', 'Private', 'Non-Investment']

  def make_owner(user, title = 'Owner' )
    transaction do
      self.maintainer_id = user.id if maintainer_id != user.id
      save
      owner = self.employees.new(:user => user, :title => title, :status => 'active' )
      owner.privilege_ids = Privilege.select(:id).all.map(&:id)
      owner.save!
    end
  end

  def create_with_payment(user, title = 'Owner' )
    self.maintainer_id = user.id unless maintainer_id
    set_payment_info
    make_owner(user, title = 'Owner' )
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

  def save_with_payment
    set_payment_info
    save
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card!"
    false
  end

  def find_employee(user_id)
    Employee.includes(:privileges).where(:company_id => id, :user_id => user_id).first
  end

  def user_is_admin?(user)
    (maintainer.id == user.id) || (find_employee(user.id).try(:admin?))
  end

  protected

  def set_payment_info
    if valid? && stripe_card_token.present? # !Account::FREE_ACCOUNT_IDS.any?{|acc_id| acc_id == account_id} # Valid and not a free account
      customer = Stripe::Customer.create(description: "#{name} - #{maintainer.email}", plan: account_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
    end
  end
  def has_stripe_token
    if !Account::FREE_ACCOUNT_IDS.any?{|acc_id| acc_id == account_id} # if it isn't a free account
      if ( stripe_customer_token.blank? && stripe_card_token.blank? ) # they must have a stripe credit card on file
        self.errors.add :base, "There is a problem with your credit card." # or else there is an error
      end
    end
    true
  end
end
