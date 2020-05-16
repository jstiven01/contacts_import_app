require 'rails_helper'

RSpec.describe 'Interface Valid/Invalid Contacts', type: :feature do
  let(:user) { create(:user) }

  describe 'Interface Valid/Invalid Contacts', focus: true do
    before(:each) do
      FactoryBot.create(:contact, birth_date: '20071019', user: user)
      FactoryBot.create(:contact, birth_date: '20071120', user: user)
      FactoryBot.create(:contact, birth_date: '20071221', user: user)
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
  end
end
