require 'rails_helper'

RSpec.describe Link, type: :model do
  let!(:link) { create :link }

  it { is_expected.to respond_to :accesses, :ip_countries }
  it { expect(link).to be_valid }

  describe 'scope :with_user' do
    it 'returns ActiveRecord relation with user email' do
      expect(Link.with_user.first.user_email).not_to be_blank
    end
  end
end
