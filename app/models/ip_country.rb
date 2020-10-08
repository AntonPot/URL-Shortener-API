class IpCountry < ApplicationRecord
  has_many :accesses, dependent: :nullify
  has_many :links, through: :accesses

  def self.parse_geoapi_response(data)
    data.transform_keys(&:underscore).delete_if { |k, _| k == 'country_code3' }
  end
end
