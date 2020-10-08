require 'rails_helper'

RSpec.describe Access, type: :model do
  it { is_expected.to respond_to :link, :ip_country }
end
