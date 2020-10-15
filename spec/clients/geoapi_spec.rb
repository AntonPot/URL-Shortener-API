require 'rails_helper'

RSpec.describe 'Geoapi' do
  describe '.fetch' do
    let(:ip) { '94.140.76.217' }
    let(:body) do
      {'country_name' => 'Slovenia'}.to_json
    end

    subject { Geoapi.fetch(ip) }

    before do
      stub_request(:get, 'http://api.ip2country.info/ip?94.140.76.217').to_return(status: 200, body: body)
    end

    it 'returns HTTParty object' do
      expect(subject).to be_kind_of HTTParty::Response
    end

    it 'responds with expected body' do
      expect(subject.body).to eq body
    end
  end
end
