require 'rails_helper'

RSpec.describe 'Links', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/links/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/links/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      post '/links', params: {link: {url: 'https://google.com'}}
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'GET /download' do
    it 'returns http success' do
      get '/links/download'
      expect(response).to have_http_status(:success)
    end
  end
end
