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

      context 'when HTTP request' do
        it 'returns status redirect' do
          subject
          expect(response).to have_http_status(:redirect)
        end

        it 'redirects to URL from Link record' do
          expect(subject).to redirect_to(link.url)
        end
      end

      context 'when JSON request' do
        subject { get "/#{link.slug}.json" }

        it 'returns status OK' do
          subject
          expect(response).to have_http_status(:ok)
        end

        it 'returns expected Link' do
          subject
          expect(json_body['id']).to eq link.id
        end
      end
    end

    context 'when Link does not exist' do
      subject { get '/foobar' }

      it 'redirects to root' do
        expect(subject).to redirect_to(root_path)
      end
    end
  end
end
