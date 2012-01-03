class AccountsController < ApplicationController
  def index
    params[:page] ||= 1
    params[:rows] ||= 20
    @accounts = Account.paginate(:page => params[:page].to_i, :per_page => params[:rows].to_i)
  end

  def show
    @account = Account.find(params[:id])
  end

  private
    def form_info

    end
end
