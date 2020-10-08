require 'rails_helper'

RSpec.describe IpCountry, type: :model do
  it { is_expected.to respond_to :accesses, :links }
end
