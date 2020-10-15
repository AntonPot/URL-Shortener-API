require 'rails_helper'

RSpec.describe 'Accesses', type: :request do
  describe 'GET /new' do
    let!(:link) { create :link }

    context 'when Link exists' do
      subject { get "/#{link.slug}" }

      it 'returns http redirect' do
        subject
        expect(response).to have_http_status(:redirect)
      end

      it 'creates new Access record' do
        allow(RecordLinkUsageJob).to receive(:perform_later)
        subject
        expect(RecordLinkUsageJob).to have_received(:perform_later).once
      end

      it 'redirects to URL from Link record' do
        expect(subject).to redirect_to(link.url)
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
