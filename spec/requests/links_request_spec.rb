require 'rails_helper'

RSpec.describe 'Links', type: :request do
  let(:user) { create :user }

  describe 'GET /index' do
    it 'assigns expected links list to @links' do
      get links_path
      expect(assigns(:links)).to eq(Link.with_full_info)
    end

    context 'when HTTP request' do
      it 'returns http status 200' do
        get links_path
        expect(response).to have_http_status(:success)
      end

      it 'renders index template' do
        get links_path
        expect(response).to render_template(:index)
      end
    end

    context 'when JSON request' do
      let!(:link) { create :link }

      it 'returns http status 200' do
        get links_path
        expect(response).to have_http_status(:success)
      end

      it 'returns a list of Links' do
        get links_path + '.json'
        expect(json_body).to be_kind_of Array
        expect(json_body.first['id']).to eq link.id
      end
    end
  end

  describe 'GET /new' do
    it 'returns http status 200' do
      get new_link_path
      expect(response).to have_http_status(:success)
    end

    it 'assigns new Link to @link' do
      get new_link_path
      expect(assigns(:link)).to be_kind_of(Link)
    end

    it 'renders new link template' do
      get new_link_path
      expect(response).to render_template(:new)
    end
  end

  describe 'GET /show' do
    let!(:link) { create :link }
    let(:path) { link_path(id: link.id) }

    it 'assigns expected link to @link' do
      get path
      expect(assigns(:link)).to eq(Link.find(link.id))
    end

    context 'when HTTP request' do
      it 'returns http status 200' do
        get path
        expect(response).to have_http_status(:success)
      end

      it 'redirects to show link template' do
        get path
        expect(response).to render_template(:show)
      end
    end

    context 'when JSON request' do
      it 'returns http status 200' do
        get path + '.json'
        expect(response).to have_http_status(:success)
      end

      it 'responds with Link object' do
        get path + '.json'
        expect(json_body['id']).to eq link.id
      end
    end
  end

  describe 'GET /create' do
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

    it 'calls Links::Create service' do
      allow(Links::Create).to receive(:run).with(params[:link]).once.and_call_original
      post links_path, params: params
      expect(Links::Create).to have_received(:run).with(params[:link]).once
    end

    context 'when HTTP request' do
      it 'returns http status 302' do
        post links_path, params: params
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to root' do
        expect(post(links_path, params: params)).to redirect_to(root_path)
      end

      context 'when failed' do
        before { allow(Links::Create).to receive(:run).and_return(failed_service) }

        it 'returns http status 302' do
          post links_path, params: params
          expect(response).to have_http_status(:redirect)
        end

        it 'redirects to new_link path' do
          expect(post(links_path, params: params)).to redirect_to(new_link_path)
        end
      end
    end

    context 'when JSON request' do
      subject { post links_path + '.json', params: params }

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
    end
  end

  describe 'DELETE /destroy' do
    pending 'tests for delete Link'
  end
end
