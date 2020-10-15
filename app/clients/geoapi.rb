class Geoapi
  include HTTParty
  base_uri 'api.ip2country.info'

  def self.fetch(ip_address)
    get('/ip', query: ip_address)
  end
end
