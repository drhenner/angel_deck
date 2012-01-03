class CompanyAdmin::CollaboratorsController < CompanyAdmin::BaseController
  helper_method :option_selected, :collaborators_selected

  def index
    params[:page] ||= 1
    params[:rows] ||= 20
    @users = company.users.paginate(:page => params[:page].to_i, :per_page => params[:rows].to_i)
    @employee = Employee.new
    @current_employee = company.find_employee(current_user.id)
  end

  def show
    @user = company.users.find(params[:id])
    @current_user_employee = company.find_employee(current_user.id)
    @user_employee = company.find_employee(@user.id)
  end

  def create
    @user = User.find_by_id(params[:employee][:user_id])
    if @user
      company.user_ids = company.user_ids + [@user.id]
      if company.save
        puts 'SAVED'
        redirect_to company_admin_company_collaborators_url(company), :notice  => "Successfully added user."
      else
        puts 'BAD '
        redirect_to company_admin_company_collaborators_url(company), :alert  => "Had an issue adding the User."
      end
    else
      redirect_to company_admin_company_collaborators_url(company), :alert  => "Had an issue adding the User."
    end
  end

  def destroy
    company.user_ids = company.user_ids - [params[:id].to_i]
    company.save
    respond_to do |format|
      #format.html
      format.json {
        render :json =>  { :company => :ok }.to_json()
      }
    end
  end

  private
    def option_selected
      ''
    end

    def collaborators_selected
      'selected'
    end

    def form_info

    end
end
