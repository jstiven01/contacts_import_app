# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'presence validations model and Factory Bot' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:birth_date) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:credit_card) }
    it { should validate_presence_of(:franchise_credit_card).with_message('Invalid credit card number') }
    it { should validate_presence_of(:email) }

    it 'has a valid factory' do
      contact = FactoryBot.build(:contact)
      expect(contact).to be_valid
    end
  end

  describe 'associations test' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'format name validations' do
    it { should allow_value('John Doe').for(:name) }
    it { should allow_value('John-Doe').for(:name) }
    it { should allow_value('John Doe1').for(:name) }
    it { should_not allow_value('John ? Doe').for(:name).with_message('special characters are not allowed except -') }
  end

  describe 'format birth date validations' do
    it 'should accept birth date format %Y%m%d  ' do
      user = FactoryBot.create(:user)
      contact_valid = FactoryBot.build(:contact, birth_date: '20071119', user: user)
      expect(contact_valid.valid?).to be_truthy
    end

    it 'should accept birth date with format of ISO 8601' do
      user = FactoryBot.create(:user)
      contact_valid = FactoryBot.build(:contact, birth_date: '2007-11-19', user: user)
      expect(contact_valid.valid?).to be_truthy
    end

    it 'should reject birth date with format different of ISO 8601' do
      user = FactoryBot.create(:user)
      contact_invalid = FactoryBot.build(:contact, user: user)
      contact_invalid.birth_date = '2007/07/01'
      expect(contact_invalid.valid?).to be_falsy
    end
  end

  describe 'format phone validations' do
    it { should allow_value('(+00) 000 000 00 00').for(:phone) }
    it { should allow_value('(+00) 000-000-00-00').for(:phone) }
    it {
      should_not allow_value('000 000 00 00').for(:phone)
                                             .with_message('only formats (+00) 000 000 00 00 and (+00) 000-000-00-00 are allowed')
    }
  end

  describe 'format email validations' do
    it { should allow_value('example@example.com').for(:email) }
    it { should_not allow_value('a@example').for(:email) }
    it {
      should validate_uniqueness_of(:email)
        .case_insensitive.scoped_to(:user_id)
        .with_message("you can't have two contacts with the same email")
    }
  end

  describe 'franchise validations' do
    it 'should accept Mastercard Card' do
      user = FactoryBot.create(:user)
      contact_valid = FactoryBot.create(:contact, credit_card: '5555555555554444', user: user)
      expect(contact_valid.franchise_credit_card).to eq('Mastercard')
    end

    it 'should accept Visa Card' do
      user = FactoryBot.create(:user)
      contact_valid = FactoryBot.create(:contact, credit_card: '4111111111111111', user: user)
      expect(contact_valid.franchise_credit_card).to eq('Visa')
    end

    it 'should reject wrong number Card' do
      user = FactoryBot.create(:user)
      contact_invalid = FactoryBot.create(:contact, user: user)
      contact_invalid.credit_card = '11111111111'
      expect(contact_invalid.valid?).to be_falsy
    end
  end

  describe 'generating 4 last digits' do
    it 'should accept American Express and show 4 last digits' do
      user = FactoryBot.create(:user)
      contact_valid = FactoryBot.create(:contact, credit_card: '371449635398431', user: user)
      expect(contact_valid.four_digits).to eq('8431')
    end
  end
end
