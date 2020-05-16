require 'rails_helper'

RSpec.describe 'Upload file contacts', type: :feature do
  describe 'importing file' do
    let(:csv_file_complete) { File.new(fixture_path + '/file_complete.csv') }
    let(:csv_file_error) { File.new(fixture_path + '/file_error.csv') }

    it 'uploads file with 4 Valid contacts and 3 Invalid Contacts and State Complete' do
      user = FactoryBot.create(:user)
      new_file = FactoryBot.create(:import_file, user: user)
      new_file.import_data(csv_file_complete)
      expect(Contact.count).to eq(4)
      expect(InvalidContact.count).to eq(3)
      expect(new_file.complete?).to be_truthy
    end

    it 'uploads file 3 Invalid Contacts and State Error' do
      user = FactoryBot.create(:user)
      new_file = FactoryBot.create(:import_file, user: user)
      new_file.import_data(csv_file_error)
      expect(InvalidContact.count).to eq(3)
      expect(new_file.error?).to be_truthy
    end
  end
end
