require 'rails_helper'

RSpec.describe GenerateCsv, type: :service do
  let(:link) { create :link }
  let(:user) { link.user }
  let(:ip_country) { create :ip_country }
  let!(:access) { create :access, ip_country: ip_country, link: link }

  subject(:service) { GenerateCsv.run(Link.with_full_info) }

  it 'generates CSV string' do
    expect(service).to be_kind_of String
  end

  it 'includes expected headers' do
    headers = service.split("\n").first.split(',')
    expect(headers).to match_array GenerateCsv::HEADERS
  end

  it 'includes expected first row' do
    row = service.split("\n").second.split(',')
    expect(row).to match_array([link.url, link.slug, user.email, '1', '1'])
  end
end
