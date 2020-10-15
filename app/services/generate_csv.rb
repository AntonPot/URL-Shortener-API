class GenerateCsv
  HEADERS = %w[url slug user_email access_count countries_count].freeze

  def self.run(data)
    service = new(data)

    service.csv_string
  end

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def csv_string
    @csv_string = CSV.generate(headers: true) do |csv|
      csv << HEADERS
      @data.each { |link| csv << link.attributes }
    end
  end
end
