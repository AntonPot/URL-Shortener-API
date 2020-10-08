class AccessesController < ApplicationController
  # This should ideally be a post request because it will perist a record
  def new
    link = Link.find_by(slug: slug)

    redirect_to(link ? link.url : root_path)
  end

  private

  def slug
    params.require(:slug)
  end
end
