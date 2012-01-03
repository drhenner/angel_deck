class CompanyAdmin::BaseController < ApplicationController
  before_filter :require_user, :require_company_admin
  helper_method :company
  private
    def require_company_admin
      if !self.try(:company)
        redirect_to root_url(:alert => 'Sorry, that page is not available.') and return
      elsif !self.try(:current_employee).admin?
        redirect_to root_url(:alert => 'Sorry, that page is not available.') and return
      end
    end

    def current_employee
      @current_employee ||= self.try(:company).find_employee(current_user.id)
    end

    def company
      @company ||= current_user.companies.find(params[:company_id])
    rescue
      nil
    end
end