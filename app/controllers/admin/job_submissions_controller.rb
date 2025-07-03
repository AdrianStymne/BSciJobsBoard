class Admin::JobSubmissionsController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "password123"

  before_action :set_job_submission, only: [ :show, :destroy, :approve ]

  def index
    @job_submissions = JobSubmission.recent
  end

  def show
  end

  def destroy
    @job_submission.destroy
    redirect_to admin_job_submissions_path, notice: "Job submission was deleted."
  end

  def approve
    job_posting = JobPosting.new(
      title: @job_submission.title,
      description: @job_submission.description,
      location: @job_submission.location,
      requires_right_to_work: @job_submission.requires_right_to_work,
      application_url: @job_submission.application_url
    )

    if job_posting.save
      @job_submission.destroy
      redirect_to admin_job_postings_path, notice: "Job submission approved and published!"
    else
      redirect_to admin_job_submission_path(@job_submission), alert: "Failed to approve submission."
    end
  end

  private

  def set_job_submission
    @job_submission = JobSubmission.find(params[:id])
  end
end
