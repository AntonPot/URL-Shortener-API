class ApplicationController < ActionController::Base
  # NOTE: Messing with request object is a No-No, but I'm adding it here to get some IP data
  before_action :inject_public_ip, if: -> { Rails.env.development? }

  private

  def inject_public_ip
    request.remote_ip = Faker::Internet.public_ip_v4_address
  end
end
