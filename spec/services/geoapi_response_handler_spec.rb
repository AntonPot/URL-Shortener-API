require 'rails_helper'

RSpec.describe GeoapiResponseHandler, type: :service do
  let(:response) { double(code: code, to_h: data) }
  let(:code) { 200 }
  let(:data) do
    {
      'countryCode' => 'SI',
      'countryCode3' => 'SVN',
      'countryName' => 'Slovenia',
      'countryEmoji' => '🇸🇮'
    }
  end

  subject(:service) { GeoapiResponseHandler.run(response) }

  context 'when successful' do
    it 'builds hash from response' do
      expect(service.data).to eq data
    end

    it 'changes keys to snake case' do
      snake_case_keys = %w[country_code country_name country_emoji]
      expect(service.data.keys).to match_array(snake_case_keys)
    end

    it 'removes countryCode3 value' do
      expect(service.data.keys).not_to include('countryCode3', 'country_code3')
    end
  end

  context 'when unsuccessful request' do
    let(:code) { 400 }

    it 'validates response status' do
      expect { service }.to raise_error(StandardError, 'Geoapi response failure')
    end
  end

  context 'when unexpected data in requests body' do
    let(:data) { {foo: 'bar'} }

    it 'validates response body' do
      expect { service }.to raise_error(StandardError, 'Expected values are missing')
    end
  end
end
