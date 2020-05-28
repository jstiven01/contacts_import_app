# frozen_string_literal: true

FactoryBot.define do
  factory :import_file do
    name { 'file.csv' }
    association :user
  end
end
