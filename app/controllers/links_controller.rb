class LinksController < ApplicationController
  before_action :set_links, only: %i[index download]

  def index; end

  def new
    @link = Link.new
  end

  def create
    service = Links::Create.call(user: current_user, url: link_params[:url], slug: link_params[:slug])
    flash[:alert] = service.alert_message
    service.successful? ? redirect_to('/') : redirect_to('/links/new')
  end

  def download
    respond_to do |f|
      f.html
      f.csv { send_data @links.to_csv, filename: "links-on-#{Time.zone.today}.csv" }
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :slug)
  end

  def set_links
    @links = Link.with_count_values.with_user
  end
end
