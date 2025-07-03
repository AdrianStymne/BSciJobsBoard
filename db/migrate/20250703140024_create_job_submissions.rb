class CreateJobSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :job_submissions do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :location, null: false
      t.boolean :requires_right_to_work, default: false, null: false
      t.string :application_url, null: false
      t.string :contact_email, null: false
      t.string :company_name, null: false
      t.datetime :submitted_at, null: false

      t.timestamps
    end

    add_index :job_submissions, :submitted_at
    add_index :job_submissions, :created_at
  end
end
