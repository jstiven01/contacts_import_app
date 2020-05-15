class Contact < ApplicationRecord
  belongs_to :user
  validates_presence_of :name, :birth_date, :phone, :address, :credit_card,
                        :franchise_credit_card, :email

  VALID_NAME_PATTERN = /\A[a-zA-Z\s\d\-]+\z/.freeze
  VALID_PHONE_PATTERN = /(\(\+\d{2}\)\s\d{3}\-\d{3}\-\d{2}\-\d{2}\z|\(\+\d{2}\)\s\d{3}\s\d{3}\s\d{2}\s\d{2}\z)/.freeze
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  validates :name, format: { with: VALID_NAME_PATTERN, message: 'special characters are not allowed except -' }
  validates :phone, format: { with: VALID_PHONE_PATTERN,
                              message: 'only formats (+00) 000 000 00 00 and (+00) 000-000-00-00 are allowed' }

  validate :custom_format_birth_date

  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: {
    case_sensitive: false,
    scope: :user_id,
    message: "you can't have two contacts with the same email"
  }

  def custom_format_birth_date
    Date.iso8601(birth_date)
  rescue StandardError
    errors.add(:birth_date, 'only formats YYYYMMDD and YYYY-MM-DD are allowed')
  end
end
