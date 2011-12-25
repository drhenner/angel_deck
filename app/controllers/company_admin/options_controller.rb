class CompanyAdmin::OptionsController < ApplicationController
  helper_method :company, :option_selected, :collaborators_selected
  def index
    #
  end

  private
    def option_selected
      'selected'
    end

    def collaborators_selected
      ''
    end

    def company
      @company ||= current_user.companies.find(params[:company_id])
    end

    def form_info

    end
end
