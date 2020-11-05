class RecordLinkUsageJob < ApplicationJob
  queue_as :default

  discard_on ActiveRecord::RecordInvalid

  def perform(link_id, ip)
    response = Geoapi.fetch(ip)
    service = GeoapiResponseHandler.run(response)

    Access.transaction do
      ip_country = IpCountry.find_or_create_by(service.data)
      Access.create!(address: ip, link_id: link_id, ip_country: ip_country)
    end
  end
end
