require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build :user, email: 'marko@email.com' }

  it { is_expected.to respond_to :links }

  describe '#parse_email' do
    it { expect(user.parse_email).to eq 'marko' }
  end
end
