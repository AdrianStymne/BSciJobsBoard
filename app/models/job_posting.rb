class JobPosting < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true
  validates :location, presence: true, length: { maximum: 255 }
  validates :application_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }
  validates :date_posted, presence: true

  scope :recent, -> { order(date_posted: :desc) }
  scope :published, -> { where("date_posted <= ?", Time.current) }

  before_validation :set_date_posted, on: :create

  def summary
    description.truncate(200)
  end

  def formatted_date_posted
    date_posted.strftime("%B %d, %Y")
  end

  private

  def set_date_posted
    self.date_posted ||= Time.current
  end
end
