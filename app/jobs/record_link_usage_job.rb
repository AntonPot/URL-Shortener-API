class RecordLinkUsageJob < ApplicationJob
  queue_as :default

  rescue_from(StandardError) do
    retry_job wait: 2.minutes, queue: :default
  end

  def perform(link, ip)
    geoapi_response = Geoapi.fetch(ip).to_h
    ip_country_data = IpCountry.parse_geoapi_response(geoapi_response)
    ip_country = IpCountry.find_or_create_by(ip_country_data)

    Access.create!(address: ip, link: link, ip_country: ip_country)
  end
end
