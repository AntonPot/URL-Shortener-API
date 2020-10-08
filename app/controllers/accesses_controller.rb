class AccessesController < ApplicationController
  # This should ideally be a post request because it will perist a record
  def new
    link = Link.find_by(slug: slug)
    # NOTE: IpCountry is hardcoded here and needs to be changed
    Access.create!(address: request.remote_ip, link: link, ip_country: IpCountry.first) if link

    redirect_to(link ? link.url : root_path)
  end

  private

  def slug
    params.require(:slug)
  end
end
