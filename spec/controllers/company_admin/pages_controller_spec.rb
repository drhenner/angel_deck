require  'spec_helper'

describe CompanyAdmin::PagesController do
  # fixtures :all
  render_views

  it "index action should redirect if not logged in" do
    company = Factory(:company)
    get :index, :company_id => company.id
    response.should redirect_to(login_url)
  end
end

describe CompanyAdmin::PagesController do
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

describe CompanyAdmin::PagesController do
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

  it "index action should render index template" do
    page = Factory(:page, :pageable => @company)
    get :index, :company_id => @company.id
    response.should render_template(:index)
  end

  it "show action should render show template" do
    page = Factory(:page, :pageable => @company)
    get :show, :company_id => @company.id, :id => page.id
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new, :company_id => @company.id
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    page = Factory.build(:page, :pageable => @company)
    Page.any_instance.stubs(:valid?).returns(false)
    post :create, :company_id => @company.id, :page => page.attributes
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    page = Factory.build(:page, :pageable => @company)
    Page.any_instance.stubs(:valid?).returns(true)
    post :create, :company_id => @company.id, :page => page.attributes
    response.should redirect_to(company_admin_company_page_url(@company, assigns[:page]))
  end

  it "edit action should render edit template" do
    page = Factory(:page, :pageable => @company)
    get :edit, :company_id => @company.id, :id => page.id
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    page = Factory(:page, :pageable => @company)
    Page.any_instance.stubs(:valid?).returns(false)
    put :update, :company_id => @company.id, :id => page.id, :page => page.attributes
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    page = Factory(:page, :pageable => @company)
    Page.any_instance.stubs(:valid?).returns(true)
    put :update, :company_id => @company.id, :id => page.id, :page => page.attributes
    response.should redirect_to(company_admin_company_page_url(@company, assigns[:page]))
  end

  it "destroy action should destroy model and redirect to index action" do
    page = Factory(:page, :pageable => @company)
    delete :destroy, :company_id => @company.id, :id => page.id
    response.should redirect_to(company_admin_company_pages_url(@company))
    Page.exists?(page.id).should be_false
  end
end
