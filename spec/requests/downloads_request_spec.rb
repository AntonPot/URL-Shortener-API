require 'rails_helper'

RSpec.describe 'Downloads', type: :request do
  let(:user) { create :user }
  let!(:link) { create :link }

  before { sign_in user }

  describe 'GET /new' do
    let(:args) do
      [GenerateCsv.run(Link.with_count_values.with_user), {filename: "links-on-#{Time.zone.today}.csv"}]
    end

    subject { get new_downloads_path, params: {format: :csv} }

    it 'returns http success' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'calls #send_data on controller' do
      expect_any_instance_of(DownloadsController).to receive(:send_data).with(*args).and_call_original
      subject
    end
  end
end
