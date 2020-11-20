class AccessesController < ApplicationController
  skip_before_action :set_current_user

  def show
    @link = Link.with_full_info.where(slug: slug).first
    raise ActiveRecord::RecordNotFound, "Couldn't find Link" unless @link

    RecordLinkUsageJob.perform_later(@link.id, request.remote_ip)
  end

  private

  def slug
    params.require(:slug)
  end
end
