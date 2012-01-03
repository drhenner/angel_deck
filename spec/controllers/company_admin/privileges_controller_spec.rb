require  'spec_helper'

describe CompanyAdmin::PrivilegesController do
  # fixtures :all
  render_views

  it "index action should redirect if not logged in" do
    company = Factory(:company)
    get :edit, :company_id => company.id, :id => 1
    response.should redirect_to(login_url)
  end
end

describe CompanyAdmin::PrivilegesController do
  # fixtures :all
  render_views

  before(:each) do
    activate_authlogic

    @user = Factory(:user)
    login_as(@user)
    @company = Factory(:company)
    employee = Factory(:employee, :user => @user, :company => @company)
    Employee.any_instance.stubs(:admin?).returns(false)
  end

  it "index action should render index template" do
    page = Factory(:page, :pageable => @company)
    get :edit, :company_id => @company.id, :id => 1
    response.should be_redirect
  end
end

describe CompanyAdmin::PrivilegesController do
  # fixtures :all
  render_views

  before(:each) do
    activate_authlogic

    @user = Factory(:user)
    login_as(@user)
    @company = Factory(:company)
    employee = Factory(:employee, :user => @user, :company => @company)
    Employee.any_instance.stubs(:admin?).returns(true)
  end

  it "edit action should render edit template" do
    employee = Factory(:employee, :company => @company)
    get :edit, :company_id => @company.id, :id => employee.id
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    employee = Factory(:employee, :company => @company)
    p = Privilege.first
    Company.any_instance.stubs(:user_is_admin?).returns(false)
    put :update, :company_id => @company.id, :id => employee.id, :employee => { :privilege_ids => p.id }
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    user = Factory(:user)
    employee = Factory(:employee, :company => @company, :user => user)
    p = Privilege.first
    put :update, :company_id => @company.id, :id => employee.id, :employee => { :privilege_ids => p.id }
    response.should redirect_to(company_admin_company_collaborator_url(@company, user))
  end

  it "destroy action should destroy model and redirect to index action" do
    employee = Factory(:employee, :company => @company)
    p = Privilege.first
    employee.privilege_ids = [p.id]
    employee.save
    delete :destroy, :company_id => @company.id, :id => employee.id, :privilege_id => p.id
    response.should redirect_to(root_url)
    employee.reload.privilege_ids.include?(p.id).should be_false
  end
end
