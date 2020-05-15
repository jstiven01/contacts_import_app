class Contact < ApplicationRecord
  belongs_to :user
  validates_presence_of :name, :birth_date, :phone, :address, :credit_card,
                        :franchise_credit_card, :email, :is_imported
end
