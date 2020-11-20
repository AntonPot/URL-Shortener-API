require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'POST #create' do
    let(:email) { Faker::Internet.email }
    let(:params) do
      {
        user: {
          email: email,
          password: 'password',
          password_confirmation: 'password'
        }
      }
    end

    subject { post registrations_path, params: params }

    context 'when successful' do
      it 'returns status 201' do
        subject
        expect(response).to have_http_status(:created)
      end

      it 'returns expected response' do
        subject
        expect(json_body['status']).to eq('created')
        expect(json_body['user'].keys).to eq %w[id email created_at updated_at]
        expect(json_body['user']['email']).to eq email
      end
    end

    context 'when unsuccessful' do
      before { create :user, email: email }

      it 'returns status 422' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        subject
        expect(json_body).to eq('Validation failed: Email has already been taken')
      end
    end
  end
end
