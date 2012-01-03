class CompanyAdmin::UsersController < CompanyAdmin::BaseController
  def index
    @users = User.where('users.email LIKE ?',"#{params[:query]}%").limit(15)
    respond_to do |format|
      #format.html
      format.json {
        render :json =>  {
          :query        => params[:query],
          :suggestions  => @users.map(&:email_first_last),
          :data         => @users.map(&:id)
        }.to_json()
      }
    end
  end

  private
    def form_info

    end
end
