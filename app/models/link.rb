class Link < ApplicationRecord
  has_many :accesses, dependent: :delete_all
  has_many :ip_countries, through: :accesses

  before_validation :assign_slug

  validates :url, :slug, presence: true
  validates :slug, uniqueness: true
  validates :url, url: true

  private

  def assign_slug
    loop do
      break unless slug.blank? || Link.where(slug: slug).exists?

      self.slug = SecureRandom.alphanumeric(10)
    end
  end
end
