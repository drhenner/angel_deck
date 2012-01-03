class CompanyAdmin::PagesController < CompanyAdmin::BaseController
  def index
    params[:page] ||= 1
    params[:rows] ||= 20
    @pages = Page.paginate(:page => params[:page].to_i, :per_page => params[:rows].to_i)
  end

  def show
    @page = company.pages.find(params[:id])
  end

  def new
    @page = Page.new
    form_info
  end

  def create
    @page = company.pages.new(params[:page])
    if @page.save
      redirect_to company_admin_company_page_url(company, @page), :notice => "Successfully created page."
    else
      form_info
      render :new
    end
  end

  def edit
    @page = company.pages.find(params[:id])
    form_info
  end

  def update
    @page = company.pages.find(params[:id])
    if @page.update_attributes(params[:page])
      redirect_to company_admin_company_page_url(company, @page), :notice  => "Successfully updated page."
    else
      form_info
      render :edit
    end
  end

  def destroy
    @page = company.pages.find(params[:id])
    @page.destroy
    redirect_to company_admin_company_pages_url(company), :notice => "Successfully destroyed page."
  end

  private
    def form_info

    end
end
