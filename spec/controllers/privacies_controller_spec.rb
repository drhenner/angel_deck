require  'spec_helper'

describe PrivaciesController do
  # fixtures :all
  render_views

  it "show action should render show template" do
    get :show
    response.should render_template(:show)
  end
end
