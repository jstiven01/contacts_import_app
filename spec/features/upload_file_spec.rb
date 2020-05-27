# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Upload file contacts', type: :feature do
  describe 'Interface My Import Files' do
    let(:user) { create(:user) }
    let(:csv_file_complete) { File.new(fixture_path + '/file_complete.csv') }

    before(:each) do
      visit new_user_session_path
      within 'form' do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'
      end
      click_link 'Import CSV File'
      fill_in 'name', with: 'name'
      fill_in 'birth_date', with: 'birth_date'
      fill_in 'phone', with: 'phone'
      fill_in 'address', with: 'address'
      fill_in 'credit_card', with: 'credit_card'
      fill_in 'email', with: 'email'
    end

    scenario 'uploads file with 4 Valid contacts and 3 Invalid Contacts and State Complete' do

      attach_file(fixture_path + '/file_complete.csv')
      click_button 'Upload Contacts'

      expect(Contact.count).to eq(4)
      expect(InvalidContact.count).to eq(3)
      expect(InvalidContact.last.error_desc).to eq('Franchise credit card Invalid credit card number')
      expect(ImportFile.last.complete?).to be_truthy
      expect(page).to have_content 'Contacts'
    end

    scenario 'uploads file 3 Invalid Contacts and State Error' do
      attach_file(fixture_path + '/file_error.csv')
      click_button 'Upload Contacts'

      expect(InvalidContact.count).to eq(3)
      expect(InvalidContact.first.error_desc).to eq(
        'Phone only formats (+00) 000 000 00 00 and (+00) 000-000-00-00 are allowed'
      )
      expect(ImportFile.last.error?).to be_truthy
    end
  end
end
