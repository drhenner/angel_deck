require  'spec_helper'

describe Registrations::CompaniesController do
  # fixtures :all
  render_views

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    company = Factory.build(:company)
    Company.any_instance.stubs(:create_with_payment).returns(false)
    post :create, :company => company.attributes
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    company = Factory.build(:company)
    Company.any_instance.stubs(:create_with_payment).returns(true)
    post :create, :company => company.attributes
    response.should redirect_to(my_deck_company_url(assigns[:company]))
  end
end
