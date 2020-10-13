require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build :user, email: 'marko@email.com' }

  it { is_expected.to respond_to :links }

  describe '#username' do
    it { expect(user.username).to eq 'marko' }
  end
end
