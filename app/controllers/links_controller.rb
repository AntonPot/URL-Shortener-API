class LinksController < ApplicationController
  def index
    @links = Link.all
  end

  def new
    @link = Link.new
  end

  def create
    link = Link.new(link_params)

    if link.save
      flash[:alert] = 'Link successfully created'
      redirect_to '/', status: :created
    else
      flash[:alert] = link.errors.full_messages.join('. ')
      redirect_to '/links/new'
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :slug)
  end
end
