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
    links, accesses = %i[links accesses].map { |t| Arel::Table.new(t) }

    select(
      accesses.project(accesses[:id].count)
      .where(accesses[:link_id].eq(links[:id]))
      .as('access_count')
    )
  }

  scope :with_countries_count, lambda {
    links, accesses, ip_countries = %i[links accesses ip_countries].map { |t| Arel::Table.new(t) }

    select(
      ip_countries.project(ip_countries[:id].count(distinct: true))
      .join(accesses).on(ip_countries[:id].eq(accesses[:ip_country_id]))
      .where(accesses[:link_id].eq(links[:id]))
      .as('countries_count')
    )
  }

  scope :with_user_email, lambda {
    links, users = %i[links users].map { |t| Arel::Table.new(t) }

    select(
      users.project(users[:email])
      .where(users[:id].eq(links[:user_id]))
      .as('user_email')
    )
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
