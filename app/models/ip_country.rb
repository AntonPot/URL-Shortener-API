# NOTE: As naming is the hardest thing in coding,
# I must confess that I'm now far from happy with this IpCountry selection.

# This should be just Country
class IpCountry < ApplicationRecord
  has_many :accesses, dependent: :nullify
  has_many :links, through: :accesses

  validates :country_name, presence: true
  validates :country_code, :country_name, :country_emoji, uniqueness: true
end
