require 'rails_helper'

RSpec.describe IpCountry, type: :model do
  it { is_expected.to respond_to :accesses, :links }
  it { is_expected.to have_many :accesses }
  it { is_expected.to have_many :links }
  it { is_expected.to validate_presence_of :country_name }
  it { is_expected.to validate_uniqueness_of :country_name }
  it { is_expected.to validate_uniqueness_of :country_emoji }
  it { is_expected.to validate_uniqueness_of :country_code }
end
