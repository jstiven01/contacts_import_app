require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validations model' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:birth_date) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:credit_card) }
    it { should validate_presence_of(:franchise_credit_card) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:is_imported) }

    it 'has a valid factory' do
      contact = FactoryBot.create(:contact)
      expect(contact).to be_valid
    end
  end
end
