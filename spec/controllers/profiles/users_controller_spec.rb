require  'spec_helper'

describe Profiles::UsersController do
  # fixtures :all
  render_views

  it "show action should render show template" do
    user = Factory(:user)
    get :show, :id => user.id
    response.should render_template(:show)
  end
end
