FactoryBot.define do
  factory :invalid_contact do
    sequence(:name) { |n| "Contact Name #{n}" }
    birth_date { '2020-05-15' }
    phone { '(+00) 000 000 00 00' }
    address { 'My Address' }
    credit_card { '371449635398431' }
    franchise_credit_card { 'MasterCard' }
    sequence(:email) { |n| "email#{n}@email.com" }
    error_desc { 'Error' }
    association :user
  end
end
