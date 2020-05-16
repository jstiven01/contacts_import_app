FactoryBot.define do
  factory :import_file do
    name { 'file.csv' }
    state { 'processing' }
    association :user
  end
end
