class LinksController < ApplicationController
  def index
    @links = Link.with_full_info

    respond_to do |f|
      f.html
      f.json
    end
  end

  def new
    @link = Link.new
  end

  def show
    @link = Link.find(params[:id])

    respond_to do |f|
      f.html
      f.json
    end
  end

  def create
    service = Links::Create.run(user: current_user, url: link_params[:url], slug: link_params[:slug])
    @link = service.link
    flash[:alert] = service.alert_message

    if service.successful?
      respond_to do |f|
        f.html { redirect_to(root_path) }
        f.json { render status: :created }
      end
    else
      respond_to do |f|
        f.html { redirect_to(new_link_path) }
        f.json { render json: @link.errors.full_messages, status: :bad_request }
      end
    end
  end

  # TODO: Introduce HTTP redirect
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
