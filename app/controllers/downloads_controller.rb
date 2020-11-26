class DownloadsController < ApplicationController
  def new
    @links = Link.with_full_info
    render csv: @links, filename: "links-on-#{Time.zone.today}"
  end
end
