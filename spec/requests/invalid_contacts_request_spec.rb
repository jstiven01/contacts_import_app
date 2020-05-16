require 'rails_helper'

RSpec.describe 'InvalidContacts', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/invalid_contacts/index'
      expect(response).to have_http_status(:success)
    end
  end
end
