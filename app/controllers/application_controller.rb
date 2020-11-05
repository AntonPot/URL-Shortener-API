class ApplicationController < ActionController::Base
  # NOTE: I'm adding random IP here to get some diverse data in development
  before_action :inject_public_ip, if: -> { Rails.env.development? }

  private

  def inject_public_ip
    request.remote_ip = Faker::Internet.public_ip_v4_address
  end
end
