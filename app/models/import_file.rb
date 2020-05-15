class ImportFile < ApplicationRecord
  belongs_to :user
  validates_presence_of :name, :state

  STATES = %w[waiting processing error complete].freeze

  STATES.each do |state|
    define_method("#{state}?") do
      self.state == state
    end

    define_method("#{state}!") do
      update_attribute(:state, state)
    end
  end

  def import_data(file)
    CSV.foreach(file.path, headers: true) do |row|
      user.contacts.create! row.to_hash
    end
  end
end
