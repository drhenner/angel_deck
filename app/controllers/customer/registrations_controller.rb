class Customer::RegistrationsController < ApplicationController
  before_filter :require_user
  helper_method :account, :cities

  def new
    @registration = true
    @user         = User.new
    @user_session = UserSession.new
    @company = Company.new(:account => account)
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new()
    #render :template => "customer/registrations/new"
  end

  def create
    @company = Company.new(params[:company])
    @company.account_id ||= Account::FREE_ID
    if @company.create_with_payment(current_user, title = 'Owner' )
      redirect_to my_deck_company_url(@company), :notice => "Successfully created company."
    else
      #@account = @company.account
      @credit_card ||= ActiveMerchant::Billing::CreditCard.new()
      render :new
    end
  end

  protected
    def account_type
      case
      when request.path.include?('semi_private')
        Account::SEMI_PRIVATE
      when request.path.include?('private_account')
        Account::PRIVATE
      when request.path.include?('selective_account')
        Account::SELECTIVE
      when request.path.include?('free_investor_account')
        Account::INVESTOR
      when request.path.include?('investor_account')
        Account::PREMIUM_INVESTOR
      when request.path.include?('free_signup')
        Account::FREE
      else
        Account::FREE
      end
    end

    def cities
      @cities ||= City.includes(:state).all.map{|c| [c.name_state_abbreviation, c.id]}
    end
      def account
        @account ||= @company.try(:account) || Account.find(Account::TYPES[self.account_type][:id])
      end
end
