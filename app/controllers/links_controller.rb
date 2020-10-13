class LinksController < ApplicationController
  def index
    @links = Link.with_count_values.with_user
  end

  def new
    @link = Link.new
  end

  def create
    service = Links::Create.run(user: current_user, url: link_params[:url], slug: link_params[:slug])
    flash[:alert] = service.alert_message
    service.successful? ? redirect_to(root_path) : redirect_to(new_link_path)
  end

  private

  def link_params
    params.require(:link).permit(:url, :slug)
  end
end
