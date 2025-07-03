class JobSubmission < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true
  validates :location, presence: true, length: { maximum: 255 }
  validates :application_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }
  validates :contact_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :company_name, presence: true, length: { maximum: 255 }

  scope :recent, -> { order(submitted_at: :desc) }

  before_validation :set_submitted_at, on: :create

  def summary
    description.truncate(200)
  end

  def formatted_submitted_date
    submitted_at.strftime("%B %d, %Y at %l:%M %p")
  end

  private

  def set_submitted_at
    self.submitted_at ||= Time.current
  end
end
