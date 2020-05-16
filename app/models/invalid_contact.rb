class InvalidContact < ApplicationRecord
  belongs_to :user
  validates_presence_of :error_desc
end
