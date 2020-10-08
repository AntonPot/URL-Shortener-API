class Link < ApplicationRecord
  has_many :accesses, dependent: :delete_all
  has_many :ip_countries, through: :accesses

  before_validation :assign_slug

  validates :url, :slug, presence: true
  validates :slug, uniqueness: true
  validates :url, url: true

  def self.to_csv
    headers = %w[url slug access_count countries_count]

    CSV.generate(headers: true) do |csv|
      csv << headers

      all.find_each do |link|
        row = link.attributes.select { |k, _| headers.include?(k) }
        row['access_count'] = link.accesses.count.to_s
        row['countries_count'] = link.ip_countries.count.to_s

        csv << row
      end
    end
  end

  private

  def assign_slug
    loop do
      break unless slug.blank? || Link.where(slug: slug).exists?

      self.slug = SecureRandom.alphanumeric(10)
    end
  end
end
