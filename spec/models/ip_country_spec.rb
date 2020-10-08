require 'rails_helper'

RSpec.describe IpCountry, type: :model do
  it { is_expected.to respond_to :accesses, :links }

  describe '.parse_geoapi_response' do
    let(:geoapi_response) do
      {
        'countryCode' => 'GB',
        'countryCode3' => 'GBR',
        'countryName' => 'United Kingdom',
        'countryEmoji' => '🇬🇧'
      }
    end

    it 'changes hash keys to snake case' do
      expect(IpCountry.parse_geoapi_response(geoapi_response).keys)
        .to match_array(%w[country_code country_name country_emoji])
    end
  end
end
