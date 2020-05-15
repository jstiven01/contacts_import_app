FactoryBot.define do
  factory :invalid_contact do
    name { 'MyString' }
    birth_date { 'MyString' }
    phone { 'MyString' }
    address { 'MyString' }
    credit_card { 'MyString' }
    franchise_credit_card { 'MyString' }
    email { 'MyString' }
    user { nil }
  end
end
