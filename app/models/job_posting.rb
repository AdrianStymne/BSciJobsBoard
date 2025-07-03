class JobPosting < ApplicationRecord
  VISA_REQUIREMENTS = [ "required", "not_required", "unknown" ].freeze

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true
  validates :application_url, length: { maximum: 500 }
  validates :date_posted, presence: true
  validates :country, length: { maximum: 255 }
  validates :visa_requirement, inclusion: { in: VISA_REQUIREMENTS }

  scope :recent, -> { order(date_posted: :desc) }
  scope :published, -> { where("date_posted <= ?", Time.current) }
  scope :approved, -> { where(approved: true) }
  scope :pending, -> { where(approved: false) }

  before_validation :set_date_posted, on: :create
  before_validation :set_default_visa_requirement, on: :create

  def summary
    description.truncate(200)
  end

  def formatted_date_posted
    date_posted.strftime("%B %d, %Y")
  end

  def visa_requirement_display
    case visa_requirement
    when "required"
      "Right to work required"
    when "not_required"
      "No right to work required"
    when "unknown"
      "Visa requirements unknown"
    end
  end

  def self.country_options
    priority_countries = [ "Remote", "Mixed", "Unknown" ]

    all_countries = [
      "Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan",
      "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina Faso", "Burundi",
      "Cabo Verde", "Cambodia", "Cameroon", "Canada", "Central African Republic", "Chad", "Chile", "China", "Colombia", "Comoros", "Congo", "Costa Rica", "Croatia", "Cuba", "Cyprus", "Czech Republic",
      "Democratic Republic of the Congo", "Denmark", "Djibouti", "Dominica", "Dominican Republic",
      "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Eswatini", "Ethiopia",
      "Fiji", "Finland", "France",
      "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana",
      "Haiti", "Honduras", "Hong Kong", "Hungary",
      "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy", "Ivory Coast",
      "Jamaica", "Japan", "Jordan",
      "Kazakhstan", "Kenya", "Kiribati", "Kuwait", "Kyrgyzstan",
      "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg",
      "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar",
      "Namibia", "Nauru", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger", "Nigeria", "North Korea", "North Macedonia", "Norway",
      "Oman",
      "Pakistan", "Palau", "Palestine", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal",
      "Qatar",
      "Romania", "Russia", "Rwanda",
      "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Korea", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Sweden", "Switzerland", "Syria",
      "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu",
      "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "Uzbekistan",
      "Vanuatu", "Vatican City", "Venezuela", "Vietnam",
      "Yemen",
      "Zambia", "Zimbabwe"
    ]

    priority_countries + all_countries.sort
  end

  def self.visa_requirement_options
    [
      [ "Right to work required", "required" ],
      [ "No right to work required", "not_required" ],
      [ "Unknown", "unknown" ]
    ]
  end

  private

  def set_date_posted
    self.date_posted ||= Time.current
  end

  def set_default_visa_requirement
    self.visa_requirement ||= "unknown"
  end
end
