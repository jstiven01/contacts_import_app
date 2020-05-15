require 'rails_helper'

RSpec.describe InvalidContact, type: :model do
  describe 'associations test' do
    it { is_expected.to belong_to(:user) }
  end
end
