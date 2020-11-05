# NOTE: Using scopes and linking them toghether is a useful way
# to limit the load on DB. Having fewer more complexed queries
# improves performance compared to many simple ones

class Link < ApplicationRecord
  has_many :accesses, dependent: :delete_all
  has_many :ip_countries, through: :accesses
  belongs_to :user

  before_validation :assign_slug

  validates :url, :slug, :user_id, presence: true
  validates :slug, uniqueness: true
  validates :url, url: true
  validates :slug, length: { maximum: 10 }
  validates :slug, format: {
    with: /\A[a-zA-Z0-9]*\z/,
    message: 'invalid characters entered'
  }
  validate :url_uniqueness

  scope :with_full_info, lambda {
    select(:id, :url, :slug).with_access_count.with_countries_count.with_user_email
  }

  scope :with_access_count, lambda {
    select <<~SQL
      ( SELECT COUNT (id) FROM accesses
        WHERE accesses.link_id = links.id ) AS access_count
    SQL
  }

  scope :with_countries_count, lambda {
    select <<~SQL
      ( SELECT COUNT(DISTINCT ip_countries.id) FROM ip_countries
        INNER JOIN accesses ON ip_countries.id = accesses.ip_country_id
        WHERE link_id = links.id ) AS countries_count
    SQL
  }

  scope :with_user_email, lambda {
    select <<~SQL
      ( SELECT users.email FROM users
        WHERE users.id = links.user_id ) AS user_email
    SQL
  }

  def short_url
    [Rails.configuration.x.host, slug].join('/')
  end

  private

  def assign_slug
    loop do
      break unless slug.blank? || Link.where(slug: slug).exists?

      self.slug = SecureRandom.alphanumeric(10)
    end
  end

  def url_uniqueness
    errors.add(:url, 'is already in DB') if Link.where(url: url, user: user).exists?
  end
end
