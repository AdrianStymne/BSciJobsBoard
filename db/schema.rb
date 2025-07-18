# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_07_03_153044) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "job_postings", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.string "application_url", null: false
    t.datetime "date_posted", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approved", default: false, null: false
    t.string "country"
    t.string "visa_requirement", default: "unknown"
    t.index ["approved"], name: "index_job_postings_on_approved"
    t.index ["country"], name: "index_job_postings_on_country"
    t.index ["created_at"], name: "index_job_postings_on_created_at"
    t.index ["date_posted"], name: "index_job_postings_on_date_posted"
    t.index ["visa_requirement"], name: "index_job_postings_on_visa_requirement"
  end
end
