# frozen_string_literal: true

class ImportFile < ApplicationRecord
  include AASM
  belongs_to :user
  validates_presence_of :name, :state

  aasm column: 'state' do
    state :processing, initial: true
    state :waiting, :error, :complete

    event :success_upload do
      transitions from: :processing, to: :complete
    end

    event :fail_upload do
      transitions from: :processing, to: :error
    end
  end

  def import_data(params_form)
    file = params_form[:file]
    error_importing = true
    CSV.foreach(file.path, headers: true) do |row|
      #p 'new contact', processing_columns(params_form, row.to_hash)
      new_contact = user.contacts.build processing_columns(params_form, row.to_hash)
      if new_contact.save
        error_importing = false
      else
        new_invalid_contact = user.invalid_contacts.build processing_columns(params_form, row.to_hash)
        new_invalid_contact.error_desc = new_contact.errors.full_messages.first
        new_invalid_contact.save
      end
    end
    if error_importing
      fail_upload!
    else
      success_upload!
    end
  end

  def processing_columns(params_form, row_hash)
    hash_relation = {
      params_form[:name].to_s => 'name',
      params_form[:birth_date].to_s => 'birth_date',
      params_form[:phone].to_s => 'phone',
      params_form[:address].to_s => 'address',
      params_form[:credit_card].to_s => 'credit_card',
      params_form[:email].to_s => 'email'
    }
    final_hash = {}
    row_hash.each do |key, element|
      final_hash[hash_relation[key]] = element if hash_relation.keys.include?(key)
    end

    final_hash
  end
end
