require  'spec_helper'

describe MyDeck::PagesController do
  # fixtures :all
  render_views

  it "index action should render index template" do
    page = Factory(:page)
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    page = Factory(:page)
    get :show, :id => page.id
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    page = Factory.build(:page)
    Page.any_instance.stubs(:valid?).returns(false)
    post :create, :page => page.attributes
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    page = Factory.build(:page)
    Page.any_instance.stubs(:valid?).returns(true)
    post :create, :page => page.attributes
    response.should redirect_to(my_deck_page_url(assigns[:page]))
  end

  it "edit action should render edit template" do
    page = Factory(:page)
    get :edit, :id => page.id
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    page = Factory(:page)
    Page.any_instance.stubs(:valid?).returns(false)
    put :update, :id => page.id, :page => page.attributes
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    page = Factory(:page)
    Page.any_instance.stubs(:valid?).returns(true)
    put :update, :id => page.id, :page => page.attributes
    response.should redirect_to(my_deck_page_url(assigns[:page]))
  end
end
