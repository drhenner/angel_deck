require  'spec_helper'

describe CompanyAdmin::UsersController do
  # fixtures :all
  render_views

  before(:each) do
    activate_authlogic

    @user = Factory(:user, :email => 'hehe@iseeyou.com')
    login_as(@user)
    @company = Factory(:company, :name => 'BBLaha')
    employee = Factory(:employee, :user => @user, :company => @company)
    Employee.any_instance.stubs(:admin?).returns(true)
  end

  it "index action should render index template" do
    user = Factory(:user)
    get :index, :company_id => @company.id, :format => :json, :query => ''
    response.body.include?(@user.email_first_last).should be_true

  end

  it "index action should render index template" do
    user = Factory(:user)
    get :index, :company_id => @company.id, :format => :json, :query => 'hehe'
    response.body.include?(@user.email_first_last).should be_true

  end

  it "index action should render index template" do
    user = Factory(:user)
    get :index, :company_id => @company.id, :format => :json, :query => 'hehed'
    response.body.include?(@user.email_first_last).should_not be_true
  end
end
