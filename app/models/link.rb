class Link < ApplicationRecord
  has_many :accesses, dependent: :delete_all
  has_many :ip_countries, through: :accesses
  belongs_to :user

  before_validation :assign_slug

  validates :url, :slug, presence: true
  validates :slug, uniqueness: true
  validates :url, url: true

  scope :with_count_values, lambda {
    select(:url, :slug).select <<~SQL
      (
        SELECT COUNT (id) FROM accesses
        WHERE accesses.link_id = links.id
      ) AS access_count,
      (
        SELECT COUNT(DISTINCT ip_countries.id) FROM ip_countries
        INNER JOIN accesses ON ip_countries.id = accesses.ip_country_id
        WHERE link_id = links.id
      ) AS countries_count
    SQL
  }

  scope :with_user, lambda {
    select <<~SQL
      (
        SELECT users.email FROM users
        WHERE users.id = links.user_id
      ) AS user_email
    SQL
  }

  def self.to_csv
    headers = %w[url slug user_email access_count countries_count]

    CSV.generate(headers: true) do |csv|
      csv << headers
      with_count_values.with_user.each { |link| csv << link.attributes }
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
