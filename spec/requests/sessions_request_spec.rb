require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let!(:user) { create :user }
  let(:email) { user.email }

  describe 'POST #create' do
    let(:params) do
      {
        user: {
          email: email,
          password: 'password'
        }
      }
    end

    subject { post login_path, params: params }

    context 'when successful' do
      it 'returns http status 201' do
        subject
        expect(response).to have_http_status(:created)
      end

      it 'returns expected response' do
        subject
        expect(json_body['status']).to eq 'created'
        expect(json_body['logged_in']).to be true
        expect(json_body['user']).to eq({'id' => user.id, 'email' => user.email})
      end
    end

    context 'when unsuccessful' do
      let(:email) { 'foobar' }

      it 'returns http status 404' do
        subject
        expect(response).to have_http_status(:not_found)
      end

      it 'returns error message' do
        subject
        expect(json_body).to eq("Couldn't find User")
      end
    end
  end

  describe 'logged_in' do
    subject { get logged_in_path }

    context 'when successful' do
      before { sign_in_as user }

      it 'returns http status 200' do
        subject
        expect(response).to have_http_status(:ok)
      end

      it 'returns expected response' do
        subject
        expect(json_body['logged_in']).to be true
        expect(json_body['user']).to eq({'id' => user.id, 'email' => user.email})
      end
    end

    context 'when unsuccessful' do
      it 'returns http status 422' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        subject
        expect(json_body).to eq('Login required')
      end
    end
  end

  describe 'logout' do
    subject { delete logout_path }

    context 'when successful' do
      before { sign_in_as user }

      it 'returns http status 200' do
        subject
        expect(response).to have_http_status(:ok)
      end

      it 'returns expected response' do
        subject
        expect(json_body).to eq({'logged_in' => false})
      end
    end

    context 'when unsuccessful' do
      it 'returns http status 422' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        subject
        expect(json_body).to eq('Login required')
      end
    end
  end
end
