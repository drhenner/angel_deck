class MyDeck::PagesController < MyDeck::BaseController
  helper_method :company
  def index
    @pages = company.pages
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new
    form_info
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect_to [:my_deck, @page], :notice => "Successfully created page."
    else
      form_info
      render :new
    end
  end

  def edit
    @page = Page.find(params[:id])
    form_info
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      redirect_to [:my_deck, @page], :notice  => "Successfully updated page."
    else
      form_info
      render :edit
    end
  end

  private
    def company
      @company ||= current_user.companies.find(params[:company_id])
    end

    def form_info

    end
end
