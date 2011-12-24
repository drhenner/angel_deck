class MyDeck::CompaniesController < MyDeck::BaseController
  helper_method :cities

  def index
    @companies = current_user.companies
    redirect_to [:my_deck, @companies.first] and return if @companies.size == 1
    redirect_to new_my_deck_company_url and return if @companies.size == 0
  end

  def show
    @company = Company.find(params[:id])
    @employee = @company.find_employee(current_user.id)
    redirect_to root_url(:notice => 'You are not allowed to view this company.') and return unless @employee
  end

  def new
    @company = Company.new
    form_info
  end

  def create
    @company = Company.new(params[:company])
    if @company.save
      @company.make_owner(current_user)
      redirect_to [:my_deck, @company], :notice => "Successfully created company."
    else
      form_info
      render :new
    end
  end

  def edit
    @company = Company.find(params[:id])
    form_info
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      redirect_to [:my_deck, @company], :notice  => "Successfully updated company."
    else
      form_info
      render :edit
    end
  end

  private
    def cities
      @cities ||= City.includes(:state).all.map{|c| [c.name_state_abbreviation, c.id]}
    end

    def form_info

    end
end
