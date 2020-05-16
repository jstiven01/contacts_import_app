require 'rails_helper'

RSpec.describe InvalidContact, type: :model do
  describe 'presence validations model and Factory Bot' do
    it { should validate_presence_of(:error_desc) }

    it 'has a valid factory' do
      invalid_contact = FactoryBot.build(:invalid_contact)
      expect(invalid_contact).to be_valid
    end

    it 'stores 4 digits' do
      invalid_contact = FactoryBot.build(:invalid_contact)
      invalid_contact.save
      expect(invalid_contact).to be_valid
      expect(invalid_contact.credit_card).to eq('8431')
    end

    it 'stores invalid contact without credit card' do
      invalid_contact = FactoryBot.build(:invalid_contact)
      invalid_contact.credit_card = ''
      invalid_contact.save
      expect(invalid_contact).to be_valid
      expect(invalid_contact.credit_card).to eq('')
    end
  end
  describe 'associations test' do
    it { is_expected.to belong_to(:user) }
  end
end
