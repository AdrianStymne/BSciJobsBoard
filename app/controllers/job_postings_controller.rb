class JobPostingsController < ApplicationController
  def index
    @job_postings = JobPosting.approved.published.recent

    # Apply country filter
    if params[:country].present?
      @job_postings = @job_postings.where(country: params[:country])
    end

    # Apply right to work filter
    if params[:requires_right_to_work].present?
      @job_postings = @job_postings.where(requires_right_to_work: params[:requires_right_to_work] == "true")
    end

    # Get unique countries for filter dropdown (only from approved jobs)
    @available_countries = JobPosting.approved.published.distinct.pluck(:country).compact.sort
  end

  def show
    @job_posting = JobPosting.approved.find(params[:id])
  end
end
