require 'rails_helper'

RSpec.describe 'Links', type: :request do
  let(:user) { create :user }

  before { sign_in_as user }

  describe 'GET #index' do
    let!(:link) { create :link }

    subject { get links_path }

    it 'returns http status 200' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'returns a list of Links' do
      subject
      expect(json_body).to be_kind_of Array
      expect(json_body.first['id']).to eq link.id
    end

    it 'assigns expected links list to @links' do
      subject
      expect(assigns(:links)).to eq(Link.with_full_info)
    end
  end

  describe 'GET #show' do
    let!(:link) { create :link }

    subject { get link_path(id: link.id) }

    it 'returns http status 200' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'responds with Link object' do
      subject
      expect(json_body['id']).to eq link.id
    end

    it 'assigns expected link to @link' do
      subject
      expect(assigns(:link)).to eq(Link.find(link.id))
    end
  end

  describe 'POST #create' do
    let(:url) { 'https://google.com' }
    let(:params) do
      {link: {url: url, slug: 'banana', user: user}}
    end
    let(:failed_service) do
      double(
        link: double(errors: double(full_messages: ['Link failed'])),
        successful?: false,
        alert_message: 'Link creation failed')
    end

    subject { post links_path, params: params }

    it 'returns http status 201' do
      subject
      expect(response).to have_http_status(:created)
    end

    it 'responds with Link object' do
      subject
      expect(json_body['url']).to eq url
    end

    context 'when failed' do
      before { allow(Links::Create).to receive(:run).and_return(failed_service) }

      it 'returns http status 400' do
        subject
        expect(response).to have_http_status(:bad_request)
      end

      it 'responds with error message' do
        subject
        expect(json_body).to eq ['Link failed']
      end
    end

    it 'calls Links::Create service' do
      allow(Links::Create).to receive(:run).with(params[:link]).once.and_call_original
      post links_path, params: params
      expect(Links::Create).to have_received(:run).with(params[:link]).once
    end
  end

  describe 'DELETE #destroy' do
    let!(:link) { create :link }

    subject { delete link_path(link.id) }

    it 'returns http status 200' do
      subject
      expect(response).to have_http_status(200)
    end

    it 'destroys the Link' do
      expect { subject }.to change(Link, :count).by(-1)
    end
  end
end
