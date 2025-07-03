class CreateJobPostings < ActiveRecord::Migration[8.0]
  def change
    create_table :job_postings do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :location, null: false
      t.boolean :requires_right_to_work, default: false, null: false
      t.string :application_url, null: false
      t.datetime :date_posted, null: false

      t.timestamps
    end

    add_index :job_postings, :date_posted
    add_index :job_postings, :created_at
  end
end
