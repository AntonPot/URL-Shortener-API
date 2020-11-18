class AccessesController < ApplicationController
  def show
    @link = Link.with_full_info.where(slug: slug).first
    return redirect_to(root_path) unless @link

    RecordLinkUsageJob.perform_later(@link.id, request.remote_ip)

    respond_to do |f|
      f.html { redirect_to(@link.url) }
      f.json
    end
  end

  private

  def slug
    params.require(:slug)
  end
end
