require 'rails_helper'

RSpec.describe RecordLinkUsageJob, type: :job do
  include ActiveJob::TestHelper

  let(:link) { create :link }
  let(:ip) { '94.114.243.196' }
  let(:job) { RecordLinkUsageJob.perform_later(link.id, ip) }

  subject { RecordLinkUsageJob.new.perform(link.id, ip) }

  it 'creates the job' do
    expect { job }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  describe '#perform' do
    let(:response) { '{\"countryName\"=>\"Slovenia\"}' }
    let(:service) { double(data: attributes_for(:ip_country)) }

    before do
      stub_request(:get, 'http://api.ip2country.info/ip?94.114.243.196')
      allow(Geoapi).to receive(:fetch).with(ip).once.and_return(response)
      allow(GeoapiResponseHandler).to receive(:run).with(response).once.and_return(service)
    end

    it 'calls Geoapi.fetch' do
      subject
      expect(Geoapi).to have_received(:fetch).with(ip).once
    end

    it 'calls GeoapiResponseHandler.run' do
      subject
      expect(GeoapiResponseHandler).to have_received(:run).with(response).once
    end

    it 'creates an Access record' do
      expect { subject }.to change(Access, :count).by(1)
    end

    it 'creates a IpCountry record' do
      expect { subject }.to change(IpCountry, :count).by(1)
    end
  end
end
