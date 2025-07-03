class JobPostingsController < ApplicationController
  def index
    @job_postings = JobPosting.approved.published.recent
  end

  def show
    @job_posting = JobPosting.approved.find(params[:id])
  end
end
