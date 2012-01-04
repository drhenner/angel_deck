class Customer::RegistrationsController < ApplicationController
  helper_method :account

  def new
    @registration = true
    @user         = User.new
    @user_session = UserSession.new
    @company = Company.new(:account => account)
    #debugger
    #render :template => "customer/registrations/new"
  end

  def create
    @user = User.new(params[:user])
    @user.format_birth_date(params[:user][:birth_date]) if params[:user][:birth_date].present?
    # Saving without session maintenance to skip
    # auto-login which can't happen here because
    # the User has not yet been activated
    if @user.save_without_session_maintenance
      @user.deliver_activation_instructions!
      UserSession.new(@user.attributes)
      flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
      redirect_to root_url
    else
      @registration = true
      @user_session = UserSession.new
      render :template => 'user_sessions/new'
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

    def newd
      account_id = account_type ? account_type[:id] : Account::FREE_ID
      @account = Account.find(account_id)
      @company = Company.new(:account => @account)
      form_info
    end

    def created
      @company = Company.new(params[:company])
      @company.account_id ||= Account::FREE_ID
      if @company.save
        redirect_to root_url, :notice => "Successfully created company."
      else
        form_info
        @account = @company.account
        render :new
      end
    end

      def account
        @account ||= Account.find(Account::TYPES[self.account_type][:id])
      end
end
