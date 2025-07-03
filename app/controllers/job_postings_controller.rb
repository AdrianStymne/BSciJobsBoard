class JobPostingsController < ApplicationController
  def index
    @job_postings = JobPosting.approved.published.recent

    # Apply country filter (multiple selection)
    if params[:countries].present? && params[:countries].any?(&:present?)
      @job_postings = @job_postings.where(country: params[:countries].reject(&:blank?))
    end

    # Apply visa requirement filter (multiple selection)
    if params[:visa_requirements].present? && params[:visa_requirements].any?(&:present?)
      @job_postings = @job_postings.where(visa_requirement: params[:visa_requirements].reject(&:blank?))
    end

    # Get unique countries and visa requirements for filter options (only from approved jobs)
    @available_countries = JobPosting.approved.published.distinct.pluck(:country).compact.sort
    @available_visa_requirements = JobPosting.approved.published.distinct.pluck(:visa_requirement).compact
  end

  def show
    @job_posting = JobPosting.approved.find(params[:id])
  end
end
