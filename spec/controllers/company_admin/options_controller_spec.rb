require  'spec_helper'

describe CompanyAdmin::OptionsController do
  # fixtures :all
  render_views

  it "index action should redirect if not logged in" do
    company = Factory(:company)
    get :index, :company_id => company.id
    response.should redirect_to(login_url)
  end
end

describe CompanyAdmin::OptionsController do
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
    get :index, :company_id => @company.id
    response.should be_redirect
  end
end

describe CompanyAdmin::OptionsController do
  # fixtures :all
  render_views

  before(:each) do
    activate_authlogic

    @user = Factory(:user)
    login_as(@user)
    @company = Factory(:company)
    @employee = Factory(:employee, :user => @user, :company => @company)

  end

  it "index action should render index template" do
    Employee.any_instance.stubs(:admin?).returns(false)
    get :index, :company_id => @company.id
    response.should_not render_template(:index)
  end

  it "index action should render index template" do
    Employee.any_instance.stubs(:admin?).returns(true)
    get :index, :company_id => @company.id
    response.should render_template(:index)
  end
end
