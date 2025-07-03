class RemoveLocationFromJobPostings < ActiveRecord::Migration[8.0]
  def change
    remove_column :job_postings, :location, :string
  end
end
