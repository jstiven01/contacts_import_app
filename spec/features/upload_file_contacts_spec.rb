require 'rails_helper'

RSpec.describe 'Upload file contacts', type: :feature do
  describe '.import' do
    let(:csv_file) { File.new(fixture_path + '/file.csv') }

    it 'updates week included in file' do
      user = FactoryBot.create(:user)
      new_file = FactoryBot.create(:import_file, user: user)
      p new_file, csv_file
      new_file.import_data(csv_file)
      p Contact.last
      # expect(week1.reload.actual_billable_hours).to eq 12
      # expect(week1.reload.actual_non_billable_hours).to eq 4
    end
  end
end
