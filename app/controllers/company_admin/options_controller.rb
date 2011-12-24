class CompanyAdmin::OptionsController < ApplicationController
  helper_method :company
  def index
    #
  end

  private
    def company
      @company ||= current_user.companies.find(params[:company_id])
    end

    def form_info

    end
end
