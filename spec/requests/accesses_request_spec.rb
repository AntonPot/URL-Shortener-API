require 'rails_helper'

RSpec.describe 'Accesses', type: :request do
  describe 'GET /new' do
    let!(:link) { create :link }
    let!(:ip_country) { create :ip_country }

    it 'returns http success' do
      get "/#{link.slug}"
      expect(response).to have_http_status(:redirect)
    end

    it 'creates new Access record' do
      expect { get "/#{link.slug}" }.to change { Access.count }.by(1)
    end
  end
end
