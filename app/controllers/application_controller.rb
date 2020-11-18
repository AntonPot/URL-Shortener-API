class ApplicationController < ActionController::Base
  include CurrentUserConcern

  # NOTE: I'm adding random IP here to get some diverse data in development
  before_action :inject_public_ip, if: -> { Rails.env.development? }
  skip_before_action :verify_authenticity_token

  rescue_from StandardError do |exception|
    render json: exception.to_json, status: :unprocessable_entity
  end

  private

  def inject_public_ip
    request.remote_ip = Faker::Internet.public_ip_v4_address
  end
end
