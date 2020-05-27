# frozen_string_literal: true

class ImportFile < ApplicationRecord
  include AASM
  belongs_to :user
  validates_presence_of :name, :state

  aasm column: 'state' do
    state :processing, initial: true
    state :waiting, :error, :complete

    event :success_upload do
      transitions from: %i[processing error], to: :complete
    end

    event :fail_upload do
      transitions from: :processing, to: :error
    end
  end

  def import_data(params_form)
    CSV.foreach(params_form[:file].path, headers: true) do |row|
      new_contact = user.contacts.build processing_columns(params_form, row.to_hash)
      if new_contact.save
        success_upload! if may_success_upload?
      else
        saving_invalid_contact(params_form, new_contact, row)
        fail_upload! if may_fail_upload?
      end
    end
  end

  def saving_invalid_contact(params_form, new_contact, row_contact)
    new_invalid_contact = user.invalid_contacts.build processing_columns(params_form, row_contact.to_hash)
    new_invalid_contact.error_desc = new_contact.errors.full_messages.first
    new_invalid_contact.save
  end

  def mapping_fields_file(params_form)
    {
      params_form[:name].to_s => 'name', params_form[:birth_date].to_s => 'birth_date',
      params_form[:phone].to_s => 'phone', params_form[:address].to_s => 'address',
      params_form[:credit_card].to_s => 'credit_card', params_form[:email].to_s => 'email'
    }
  end

  def processing_columns(params_form, row_hash)
    final_hash = {}
    hash_relation = mapping_fields_file(params_form)
    row_hash.each do |key, element|
      final_hash[hash_relation[key]] = element if hash_relation.keys.include?(key)
    end

    final_hash
  end
end
