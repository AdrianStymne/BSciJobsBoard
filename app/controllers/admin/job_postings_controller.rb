class Admin::JobPostingsController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "password123"

  before_action :set_job_posting, only: [ :show, :edit, :update, :destroy, :approve ]

  def index
    @job_postings = JobPosting.all.order(created_at: :desc)
    @pending_count = JobPosting.pending.count
  end

  def show
  end

  def new
    @job_posting = JobPosting.new
  end

  def create
    @job_posting = JobPosting.new(job_posting_params)

    if @job_posting.save
      redirect_to admin_job_postings_path, notice: "Job posting was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @job_posting.update(job_posting_params)
      redirect_to admin_job_posting_path(@job_posting), notice: "Job posting was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @job_posting.destroy
    redirect_to admin_job_postings_path, notice: "Job posting was successfully deleted."
  end

  def approve
    @job_posting.update(approved: true)
    redirect_to admin_job_postings_path, notice: "Job posting approved!"
  end

  private

  def set_job_posting
    @job_posting = JobPosting.find(params[:id])
  end

  def job_posting_params
    params.require(:job_posting).permit(:title, :description, :location, :country, :requires_right_to_work, :application_url, :approved)
  end
end
