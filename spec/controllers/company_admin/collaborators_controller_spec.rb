require  'spec_helper'

describe CompanyAdmin::CollaboratorsController do
  # fixtures :all
  render_views

  it "index action should redirect if not logged in" do
    company = Factory(:company)
    get :index, :company_id => company.id
    response.should redirect_to(login_url)
  end
end

describe CompanyAdmin::CollaboratorsController do
  render_views

  before(:each) do
    activate_authlogic

    @user = Factory(:user)
    login_as(@user)
    @company = Factory(:company)
  end

  it "index action should render index template" do
    employee = Factory(:employee, :user => @user, :company => @company)
    Employee.any_instance.stubs(:admin?).returns(true)
    get :index, :company_id => @company.id
    response.should render_template(:index)
  end

  it "show action should redirect if not an admin in the company" do
    get :show, :company_id => @company.id, :id => @user.id
    response.should be_redirect
  end

  it "show action should render show template" do
    employee = Factory(:employee, :user => @user, :company => @company)
    Employee.any_instance.stubs(:admin?).returns(true)
    get :show, :company_id => @company.id, :id => @user.id
    response.should render_template(:show)
  end

  it "show action should redirect if you are not an admin of the company" do
    employee = Factory(:employee, :user => @user, :company => @company)
    Employee.any_instance.stubs(:admin?).returns(false)
    get :show, :company_id => @company.id, :id => @user.id
    response.should be_redirect
  end

  it "create action should redirect when model is valid" do
    user = Factory(:user)
    #employee = Factory(:employee, :user => user, :company => @company)
    currentemployee = Factory(:employee, :user => @user, :company => @company)
    Employee.any_instance.stubs(:admin?).returns(true)
    Company.any_instance.stubs(:valid?).returns(true)
    post :create, :company_id => @company.id, :id => user.id, :user => user.attributes, :employee => {:user_id => user.id }
    @company.find_employee(user.id).should_not be_nil
    response.should redirect_to(company_admin_company_collaborators_url( @company))
  end

  it "destroy action should destroy model and redirect to index action" do
    user = Factory(:user)
    employee = Factory(:employee, :user => user, :company => @company)
    currentemployee = Factory(:employee, :user => @user, :company => @company)
    Employee.any_instance.stubs(:admin?).returns(true)
    delete :destroy, :company_id => @company.id, :id => user.id, :format => :json
    @company.find_employee(user.id).should be_nil
    response.body.include?('ok').should be_true
  end

end
