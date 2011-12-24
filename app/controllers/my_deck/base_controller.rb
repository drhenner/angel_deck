class MyDeck::BaseController < ApplicationController
  before_filter :require_permission
  def require_permission
    require_user
  end
end