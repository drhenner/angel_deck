class CompanyAdmin::OptionsController < CompanyAdmin::BaseController
  helper_method :option_selected, :collaborators_selected, :accounts
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

    def accounts
      @accounts ||= Account.all.map{|a| [a.name_with_price, a.id]}
    end

    def form_info

    end
end
