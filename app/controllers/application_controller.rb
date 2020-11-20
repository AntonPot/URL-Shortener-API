class ApplicationController < ActionController::Base
  include CurrentUserConcern
  skip_before_action :verify_authenticity_token

  # NOTE: I'm adding random IP here to get some diverse data in development
  before_action :inject_public_ip, if: -> { Rails.env.development? }

  rescue_from StandardError do |exception|
    render json: exception.to_json, status: :unprocessable_entity
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: exception.to_json, status: :not_found
  end

  private

  def inject_public_ip
    request.remote_ip = Faker::Internet.public_ip_v4_address
  end
end
