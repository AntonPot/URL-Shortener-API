require 'rails_helper'

RSpec.describe 'Downloads', type: :request do
  let(:user) { create :user }
  let!(:link) { create :link }

  before { sign_in_as user }

  describe 'GET #new' do
    let(:args) do
      [GenerateCsv.run(Link.with_full_info), {filename: "links-on-#{Time.zone.today}.csv"}]
    end
    let(:csv_string) do
      <<~HEREDOC
        url,slug,user_email,access_count,countries_count
        https://google.com,#{link.slug},#{link.user.email},0,0
      HEREDOC
    end

    subject { get new_downloads_path, params: {format: :csv} }

    it 'returns http success' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'calls #send_data on controller' do
      subject
      expect(response.body).to eq csv_string
    end
  end
end
