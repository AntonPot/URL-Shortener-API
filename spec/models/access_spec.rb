require 'rails_helper'

RSpec.describe Access, type: :model do
  it { is_expected.to respond_to :link, :ip_country }
  it { is_expected.to belong_to(:link) }
  it { is_expected.to belong_to(:ip_country) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:link_id) }
  it { is_expected.to validate_presence_of(:ip_country_id) }
end
