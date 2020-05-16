require 'rails_helper'

RSpec.describe 'Interface Valid/Invalid Contacts', type: :feature do
  let(:user) { create(:user) }

  describe 'Interface Valid/Invalid Contacts' do
    before(:each) do
      FactoryBot.create(:contact, birth_date: '20071019', user: user)
      FactoryBot.create(:contact, birth_date: '20071120', user: user)
      FactoryBot.create(:contact, birth_date: '20071221', user: user)
      FactoryBot.create(:invalid_contact, birth_date: '2007/1120',
                                          error_desc: 'only formats YYYYMMDD and YYYY-MM-DD are allowed', user: user)
      FactoryBot.create(:invalid_contact, name: '????',
                                          error_desc: 'special characters are not allowed except -', user: user)
      visit root_path
      within 'form' do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'
      end
    end

    scenario 'Creating a Valid Contacts succesfully!' do
      click_link 'Current Contacts'
      expect(page).to have_content '2007 October 19'
      expect(page).to have_content '2007 November 20'
      expect(page).to have_content '2007 December 21'
      expect(page).to have_content 'Contact Name 1'
      expect(page).to have_content 'email2@email.com'
    end

    scenario 'Creating a Invalid Contacts succesfully!' do
      click_link 'Invalid Contacts'
      expect(page).to have_content '2007/1120'
      expect(page).to have_content 'only formats YYYYMMDD and YYYY-MM-DD are allowed'
      expect(page).to have_content '????'
      expect(page).to have_content 'special characters are not allowed except -'
    end
  end
end
