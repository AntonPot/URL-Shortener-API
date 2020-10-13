class AccessesController < ApplicationController
  skip_before_action :authenticate_user!

  # NOTE: #new should in this case ideally be a POST action
  # because it will create a record in the background.
  # Open-ended routes are only available for GET requests.
  # For shortenting the URL it made more sense to go with GET.
  def new
    link = Link.find_by(slug: slug)
    return redirect_to(root_path) unless link

    RecordLinkUsageJob.perform_later(link, request.remote_ip)
    redirect_to(link.url)
  end

  private

  def slug
    params.require(:slug)
  end
end
