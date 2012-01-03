require  'spec_helper'

describe AccountsController do
  # fixtures :all
  render_views

  it "index action should render index template" do
    account = Factory(:account)
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    account = Factory(:account)
    get :show, :id => account.id
    response.should render_template(:show)
  end
end
