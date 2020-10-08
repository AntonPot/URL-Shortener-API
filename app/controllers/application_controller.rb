class ApplicationController < ActionController::Base
  # NOTE: Messing with request object is a No-No, but I'm adding it here to get some IPs
  before_action :inject_public_ip, if: -> { Rails.env.development? }
  before_action :authenticate_user!

  private

  def inject_public_ip
    request.remote_ip = Faker::Internet.public_ip_v4_address
  end
end
