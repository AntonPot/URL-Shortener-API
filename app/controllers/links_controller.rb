class LinksController < ApplicationController
  before_action :set_links, only: %i[index download]

  def index; end

  def new
    @link = Link.new
  end

  def create
    link = Link.new(link_params)

    if link.save
      flash[:alert] = 'Link successfully created'
      redirect_to '/'
    else
      flash[:alert] = link.errors.full_messages.join('. ')
      redirect_to '/links/new'
    end
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
    @links = Link.with_count_values
  end
end
