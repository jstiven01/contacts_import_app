require 'rails_helper'

RSpec.describe ImportFile, type: :model do
  describe 'validations model' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:state) }
    it 'has a valid factory' do
      user = FactoryBot.create(:import_file)
      expect(user).to be_valid
    end
  end

  describe 'associations test' do
    it { is_expected.to belong_to(:user) }
  end
end
