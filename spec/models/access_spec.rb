require 'rails_helper'

RSpec.describe Access, type: :model do
  # NOTE: Creating a record is not a good practice, :build should be used whenever possible.
  # I'm creating a record here to trigger all factories,
  # since Access model is the most dependend on others.
  subject(:access) { create :access }

  it { is_expected.to respond_to :link, :ip_country }
  it { is_expected.to be_valid }
end
