FactoryBot.define do
  factory :import_file do
    name { 'MyString' }
    state { 'processing' }
    association :user
  end
end
