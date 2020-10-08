class AccessesController < ApplicationController
  # This should ideally be a post request because it will perist a record
  def new
    link = Link.find_by(slug: slug)
    return root_path unless link

    RecordLinkUsageJob.perform_later(link, request.remote_ip)
    redirect_to(link.url)
  end

  private

  def slug
    params.require(:slug)
  end
end
