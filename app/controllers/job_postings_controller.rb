class JobPostingsController < ApplicationController
  def index
    @job_postings = JobPosting.published.recent
  end

  def show
    @job_posting = JobPosting.find(params[:id])
  end
end
