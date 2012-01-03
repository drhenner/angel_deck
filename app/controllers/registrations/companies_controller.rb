class Registrations::CompaniesController < ApplicationController
  def new
    account_id = account_type ? account_type[:id] : Account::FREE_ID
    @account = Account.find(account_id)
    @company = Company.new(:account => @account)
    form_info
  end

  def create
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

  private
    def account_type
      params[:account_type] && Account::TYPES[params[:account_type]]
    end

    def form_info

    end
end
