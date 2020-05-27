# frozen_string_literal: true

class InvalidContact < ApplicationRecord
  belongs_to :user
  validates_presence_of :error_desc
  after_validation :hide_credit_card

  def hide_credit_card
    self.credit_card = credit_card.last(4) if credit_card
  end
end
