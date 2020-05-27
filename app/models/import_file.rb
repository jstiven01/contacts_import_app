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
      if new_contact.save && may_success_upload?
        success_upload!
      else
        saving_invalid_contact!(params_form, new_contact, row)
      end
    end
  end

  def saving_invalid_contact!(params_form, new_contact, row_contact)
    new_invalid_contact = user.invalid_contacts.build processing_columns(params_form, row_contact.to_hash)
    new_invalid_contact.error_desc = new_contact.errors.full_messages.first
    new_invalid_contact.save
    fail_upload! if may_fail_upload?
  end

  def mapping_fields_file(params_form)
    fields = %w[name birth_date phone address credit_card email]
    fields.each_with_object({}) do |k, hash|
      hash[params_form[k]] = k
    end
  end

  def processing_columns(params_form, row_hash)
    final_hash = {}
    hash_relation = mapping_fields_file(params_form)
    row_hash.each do |key, element|
      next unless hash_relation.keys.include?(key)

      final_hash[hash_relation[key]] = element
    end

    final_hash
  end
end
