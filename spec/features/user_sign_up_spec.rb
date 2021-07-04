# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User sign up', type: :feature do
  describe 'User sign up cases' do
    before(:each) do
      visit new_user_session_path
      click_link 'Sign up'
      within 'form' do
        fill_in 'Email', with: 'kingLear@tragedy.com'
        fill_in 'Password', with: 'aaa111'
        fill_in 'Password confirmation', with: 'aaa111'
      end
    end

    scenario 'User signs up successfully' do
      click_button 'Sign up'
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
  end
end
