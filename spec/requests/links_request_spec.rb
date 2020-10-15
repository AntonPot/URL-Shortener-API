require 'rails_helper'

RSpec.describe 'Links', type: :request do
  let(:user) { create :user }

  before { sign_in user }

  describe 'GET /index' do
    it 'returns http success' do
      get links_path
      expect(response).to have_http_status(:success)
    end

    it 'assigns expected ActiveRecord::Relation to @links' do
      get links_path
      expect(assigns(:links)).to eq(Link.with_count_values.with_user)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_link_path
      expect(response).to have_http_status(:success)
    end

    it 'assigns new Link to @link' do
      get new_link_path
      expect(assigns(:link)).to be_kind_of(Link)
    end
  end

  describe 'GET /create' do
    let(:params) do
      {link: {url: 'https://google.com', slug: 'banana', user: user}}
    end

    subject { post '/links', params: params }

    it 'returns http redirect' do
      subject
      expect(response).to have_http_status(:redirect)
    end

    it 'calls Links::Create service' do
      allow(Links::Create).to receive(:run).with(params[:link]).once.and_call_original
      subject
      expect(Links::Create).to have_received(:run).with(params[:link]).once
    end

    it 'redirects to root' do
      expect(subject).to redirect_to(root_path)
    end
  end
end
