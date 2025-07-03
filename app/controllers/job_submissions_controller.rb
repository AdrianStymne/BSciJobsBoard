class JobSubmissionsController < ApplicationController
  def new
    @job_posting = JobPosting.new
  end

  def create
    @job_posting = JobPosting.new(job_posting_params)
    @job_posting.approved = false # Always require approval for public submissions

    # Set default values for fields not in the simplified form
    @job_posting.location = @job_posting.country || "Location TBD"
    @job_posting.requires_right_to_work = false

    if @job_posting.save
      redirect_to root_path, notice: "Thank you! Your job submission has been received and will be reviewed shortly."
    else
      render :new
    end
  end

  private

  def job_posting_params
    params.require(:job_posting).permit(:title, :description, :country, :application_url)
  end
end
