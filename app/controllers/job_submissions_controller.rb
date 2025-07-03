class JobSubmissionsController < ApplicationController
  def new
    @job_submission = JobSubmission.new
  end

  def create
    @job_submission = JobSubmission.new(job_submission_params)

    if @job_submission.save
      redirect_to root_path, notice: "Thank you! Your job submission has been received and is under review."
    else
      render :new
    end
  end

  private

  def job_submission_params
    params.require(:job_submission).permit(:title, :description, :location, :requires_right_to_work, :application_url, :contact_email, :company_name)
  end
end
