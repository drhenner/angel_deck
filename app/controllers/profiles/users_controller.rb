class Profiles::UsersController < ApplicationController
  def show
    @user = User.includes(:companies).find(params[:id])
  end

end
