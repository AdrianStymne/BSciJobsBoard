class JobSubmissionsController < ApplicationController
  def new
    @job_posting = JobPosting.new
  end

  def create
    @job_posting = JobPosting.new(job_posting_params)
    @job_posting.approved = false # Always require approval for public submissions
    @job_posting.visa_requirement = "unknown" # Default for public submissions

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
