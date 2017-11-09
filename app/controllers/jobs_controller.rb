class JobsController < ApplicationController

  def index
    @jobs = case params[:order]
              when 'by_lower_bound'
                Job.published.order("wage_lower_bound DESC")
              when 'by_upper_bound'
                Job.published.order("wage_upper_bound DESC")
              else
                Job.published.recent
              end
  end

  def show
    @job = Job.find(params[:id])
    if @job.is_hidden
      flash[:warning] = "This job already archieved"
      redirect_to root_path
    end
  end

  private
  def job_params
    params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden)
  end

end
