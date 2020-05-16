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
    error_importing = true
    CSV.foreach(file.path, headers: true) do |row|
      new_contact = user.contacts.build row.to_hash
      if new_contact.save
        error_importing = false
      else
        new_invalid_contact = user.invalid_contacts.build row.to_hash
        new_invalid_contact.error_desc = new_contact.errors.full_messages.first
        new_invalid_contact.save
      end
    end
    if error_importing
      error!
    else
      complete!
    end
  end
end
