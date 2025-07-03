class AddApprovedAndCountryToJobPostings < ActiveRecord::Migration[8.0]
  def change
    add_column :job_postings, :approved, :boolean, default: false, null: false
    add_column :job_postings, :country, :string

    add_index :job_postings, :approved
    add_index :job_postings, :country
  end
end
