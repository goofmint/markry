class My::SummariesController < My::ApplicationController
  def index
    @summaries = current_user.summaries.page(params[:page]).per(20)
  end
  
  def new
    @summary = current_user.summaries.new
  end

  def create
    @summary = current_user.summaries.new(create_params)
    if @summary.save
      return redirect_to(edit_my_summary_path(@summary.temporary_code))
    else
      return render(:action => :new)
    end
  end

  def edit
    @summary = current_user.summaries.where(:enable_flag => false, :temporary_code => params[:id]).first || current_user.summaries.where(:enable_flag => true, :id => params[:id]).first
    unless @summary
      flash[:error] = "Your summary not found."
      return redirect_to(my_summaries_path)
    end
  end

  def update
    @summary = current_user.summaries.where(:enable_flag => false, :temporary_code => params[:id]).first
    unless @summary
      return head(404)
    end
    @summary.update_attributes update_params
    if params[:public]
      @summary.update_attributes :publish_at => Time.now, :enable_flag => true
    end
  end
  
  private
  def create_params
    params.require(:summary).permit(:title)
  end

  def update_params
    params.require(:summary).permit(:body, :string_tag)
  end
end
