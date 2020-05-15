require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations model' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it 'has a valid factory' do
      user = FactoryBot.create(:user)
      expect(user).to be_valid
    end
  end
end
