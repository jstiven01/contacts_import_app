require 'rails_helper'

RSpec.describe 'Upload file contacts', type: :feature do
  describe 'importing file' do
    let(:csv_file) { File.new(fixture_path + '/file.csv') }

    it 'uploads file with 4 Valid contacts and 3 Invalid Contacts' do
      user = FactoryBot.create(:user)
      new_file = FactoryBot.create(:import_file, user: user)
      new_file.import_data(csv_file)
      expect(Contact.count).to eq(4)
      expect(InvalidContact.count).to eq(3)
    end
  end
end
