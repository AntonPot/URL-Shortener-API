class DownloadsController < ApplicationController
  def new
    @links = Link.with_full_info

    respond_to do |f|
      f.html
      f.csv { send_data(GenerateCsv.run(@links), filename: "links-on-#{Time.zone.today}.csv") }
    end
  end
end
