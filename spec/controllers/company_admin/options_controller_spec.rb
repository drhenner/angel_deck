require  'spec_helper'

describe CompanyAdmin::OptionsController do
  # fixtures :all
  render_views

  before(:each) do
    activate_authlogic

    @user = Factory(:user)
    login_as(@user)
  end

  it "index action should render index template" do
    company = Factory(:company)
    get :index, :company_id => company.id
    response.should_not render_template(:index)
  end

  it "index action should render index template" do
    company = Factory(:company)
    employee = Factory(:employee, :company => company, :user => @user)
    employee.stubs(:privileges).returns(Privilege.find_by_name(:admin))
    get :index, :company_id => company.id
    response.should render_template(:index)
  end
end
