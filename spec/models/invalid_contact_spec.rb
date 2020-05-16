require 'rails_helper'

RSpec.describe InvalidContact, type: :model do
  describe 'presence validations model and Factory Bot' do
    it { should validate_presence_of(:error_desc) }

    it 'has a valid factory' do
      contact = FactoryBot.build(:contact)
      expect(contact).to be_valid
    end
  end
  describe 'associations test' do
    it { is_expected.to belong_to(:user) }
  end
end
