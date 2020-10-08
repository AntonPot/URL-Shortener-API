class IpCountry < ApplicationRecord
  has_many :accesses
  has_many :links, through: :accesses
end
