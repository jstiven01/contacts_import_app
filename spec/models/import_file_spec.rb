# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportFile, type: :model do
  let(:user) { create(:user) }
  describe 'validations model' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:state) }
    it 'has a valid factory' do
      user = FactoryBot.create(:import_file)
      expect(user).to be_valid
    end
  end

  describe 'state file transitions' do
    before(:each) do
      @file = FactoryBot.create(:import_file, user: user)
    end
    it 'validates default state' do
      expect(@file).to have_state(:processing)
    end

    it 'validates possible transitions' do
      expect(@file).to transition_from(:processing).to(:complete).on_event(:success_upload)
      expect(@file).not_to transition_from(:processing).to(:waiting).on_event(:success_upload)
      expect(@file).to transition_from(:processing).to(:error).on_event(:fail_upload)
    end
  end

  describe 'associations test' do
    it { is_expected.to belong_to(:user) }
  end
end
