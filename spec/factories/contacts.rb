FactoryBot.define do
  factory :contact do
    sequence(:name) { |n| "Contact Name #{n}" }
    birth_date { '2020-05-15' }
    phone { '(+00) 000 000 00 00' }
    address { 'My Address' }
    credit_card { '371449635398431' }
    four_digits { '' }
    franchise_credit_card { 'MasterCard' }
    sequence(:email) { |n| "email#{n}@email.com" }
    association :user
  end
end
