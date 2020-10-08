require 'rails_helper'

RSpec.describe RecordLinkUsageJob, type: :job do
  include ActiveJob::TestHelper

  let(:ip) { '94.114.243.196' }
  let(:link) { create :link }

  subject(:job) { RecordLinkUsageJob.perform_later(link, ip) }

  it 'creates the job' do
    expect { job }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end
end
