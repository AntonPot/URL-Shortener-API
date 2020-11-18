class LinksController < ApplicationController
  def index
    @links = Link.with_full_info
  end

  def show
    @link = Link.find(params[:id])
  end

  def create
    service = Links::Create.run(user: current_user, url: link_params[:url], slug: link_params[:slug])
    @link = service.link
    flash[:alert] = service.alert_message

    if service.successful?
      render json: @link, status: :created
    else
      render json: @link.errors.full_messages, status: :bad_request
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    head :ok
  end

  private

  def link_params
    params.require(:link).permit(:url, :slug)
  end
end
