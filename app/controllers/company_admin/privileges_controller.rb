class CompanyAdmin::PrivilegesController < CompanyAdmin::BaseController
  helper_method :privileges

  def edit
    @employee = Employee.find(params[:id])
    form_info
  end

  def update
    @employee = company.employees.find(params[:id])
    params[:employee][:privilege_ids] ||= []
    @employee.privilege_ids = params[:employee][:privilege_ids]
    if company.user_is_admin?(current_user) && @employee.save
      redirect_to company_admin_company_collaborator_url(company, @employee.user), :notice  => "Successfully updated privileges."
    else
      form_info
      render :edit
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @privilege = Privilege.find(params[:privilege_id])
    @employee.privilege_ids = @employee.privilege_ids - [@privilege.id] #.destroy
    @employee.save
    redirect_to root_url, :notice => "Successfully removed privilege."
  end

  private
    def privileges
      @privileges ||= Privilege.all#.map{|p| [p.name, p.id]}
    end
    def form_info

    end
end
