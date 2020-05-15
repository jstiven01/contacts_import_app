class Contact < ApplicationRecord
  belongs_to :user
  validates_presence_of :name, :birth_date, :phone, :address, :credit_card,
                        :franchise_credit_card, :email, :is_imported

  VALID_NAME_PATTERN = /\A[a-zA-Z\s\d\-]+\z/.freeze
  validates :name, format: { with: VALID_NAME_PATTERN, message: 'special characters are not allowed except -' }

  validate :custom_format_birth_date

  def custom_format_birth_date
    Date.iso8601(birth_date)
  rescue StandardError
    errors.add(:birth_date, 'only formats YYYYMMDD and YYYY-MM-DD are allowed')
  end
end
