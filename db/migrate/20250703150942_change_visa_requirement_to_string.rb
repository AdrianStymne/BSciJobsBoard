class ChangeVisaRequirementToString < ActiveRecord::Migration[8.0]
  def up
    # Add new string column
    add_column :job_postings, :visa_requirement, :string, default: 'unknown'

    # Migrate existing data
    JobPosting.reset_column_information
    JobPosting.find_each do |job_posting|
      if job_posting.requires_right_to_work == true
        job_posting.update_column(:visa_requirement, 'required')
      elsif job_posting.requires_right_to_work == false
        job_posting.update_column(:visa_requirement, 'not_required')
      else
        job_posting.update_column(:visa_requirement, 'unknown')
      end
    end

    # Remove old boolean column
    remove_column :job_postings, :requires_right_to_work

    # Add index
    add_index :job_postings, :visa_requirement
  end

  def down
    # Add back boolean column
    add_column :job_postings, :requires_right_to_work, :boolean, default: false

    # Migrate data back
    JobPosting.reset_column_information
    JobPosting.find_each do |job_posting|
      requires_work = case job_posting.visa_requirement
      when 'required'
                       true
      when 'not_required', 'unknown'
                       false
      else
                       false
      end
      job_posting.update_column(:requires_right_to_work, requires_work)
    end

    # Remove string column
    remove_index :job_postings, :visa_requirement
    remove_column :job_postings, :visa_requirement
  end
end
