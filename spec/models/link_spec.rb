require 'rails_helper'

RSpec.describe Link, type: :model do
  let(:link) { build :link }

  it { is_expected.to respond_to :accesses, :ip_countries }
  it { expect(link).to be_valid }
end
