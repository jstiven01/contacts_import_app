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
      expect(InvalidContact.last.error_desc).to eq('Franchise credit card Invalid credit card number')
      expect(new_file.complete?).to be_truthy
    end

    it 'uploads file 3 Invalid Contacts and State Error' do
      user = FactoryBot.create(:user)
      new_file = FactoryBot.create(:import_file, user: user)
      new_file.import_data(csv_file_error)
      expect(InvalidContact.count).to eq(3)
      expect(InvalidContact.first.error_desc).to eq(
        'Phone only formats (+00) 000 000 00 00 and (+00) 000-000-00-00 are allowed'
      )
      expect(new_file.error?).to be_truthy
    end
  end

  describe 'Interface My Import Files', focus: true do
    let(:user) { create(:user) }
    let(:csv_file_complete) { File.new(fixture_path + '/file_complete.csv') }

    before(:each) do
      new_file = FactoryBot.create(:import_file, user: user)
      new_file.import_data(csv_file_complete)
      visit root_path
      within 'form' do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'
      end
    end

    scenario 'Creating a Valid Contacts succesfully!' do
      click_link 'My Imported Files'
      expect(page).to have_content 'file.csv'
    end
  end
end
