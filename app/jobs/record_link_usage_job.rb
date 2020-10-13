class RecordLinkUsageJob < ApplicationJob
  queue_as :default

  rescue_from(StandardError) do
    retry_job(wait: 2.minutes, queue: :default)
  end

  def perform(link, ip)
    response = Geoapi.fetch(ip)
    serivce = GeoapiResponseHandler.run(response)

    Access.transaction do
      ip_country = IpCountry.find_or_create_by(serivce.data)
      Access.create!(address: ip, link: link, ip_country: ip_country)
    end
  end
end
