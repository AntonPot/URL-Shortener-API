require 'rails_helper'

RSpec.describe 'Accesses', type: :request do
  describe 'GET /show' do
    let!(:link) { create :link }

    context 'when Link exists' do
      subject { get "/#{link.slug}" }

      it 'creates new Access record' do
        allow(RecordLinkUsageJob).to receive(:perform_later)
        subject
        expect(RecordLinkUsageJob).to have_received(:perform_later).once
      end

      it 'returns status 200' do
        subject
        expect(response).to have_http_status(:ok)
      end

      it 'returns expected Link' do
        subject
        expect(json_body['id']).to eq link.id
      end
    end

    context 'when Link does not exist' do
      subject { get '/foobar' }

      it 'returns status 422' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        subject
        expect(json_body).to eq("Link doesn't exist")
      end
    end
  end
end
