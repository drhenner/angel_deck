require  'spec_helper'

describe MyDeck::CompaniesController do
  # fixtures :all
  render_views

  before(:each) do
    activate_authlogic

    @user = Factory(:user)
    login_as(@user)
  end

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
    response.should redirect_to(new_my_deck_company_url())
  end

  it "index action should render index template" do
    company = Factory(:company)
    employee = Factory(:employee, :company => company, :user => @user)
    get :index
    response.should redirect_to(my_deck_company_url(company))
  end

  it "index action should render index template" do
    company   = Factory(:company)
    company2  = Factory(:company)
    employee  = Factory(:employee, :company => company, :user => @user)
    employee2 = Factory(:employee, :company => company2, :user => @user)
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    company = Factory(:company)
    get :show, :id => company.id
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    company = Factory.build(:company)
    Company.any_instance.stubs(:valid?).returns(false)
    post :create, :company => company.attributes
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    company = Factory.build(:company)
    Company.any_instance.stubs(:valid?).returns(true)
    post :create, :company => company.attributes
    response.should redirect_to(my_deck_company_url(assigns[:company]))
  end

  it "edit action should render edit template" do
    company = Factory(:company)
    get :edit, :id => company.id
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    company = Factory(:company)
    Company.any_instance.stubs(:valid?).returns(false)
    put :update, :id => company.id, :company => company.attributes
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    company = Factory(:company)
    Company.any_instance.stubs(:valid?).returns(true)
    put :update, :id => company.id, :company => company.attributes
    response.should redirect_to(my_deck_company_url(assigns[:company]))
  end
end
