require 'rails_helper'

RSpec.describe 'Accesses', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get '/accesses/create'
      expect(response).to have_http_status(:redirect)
    end
  end
end
