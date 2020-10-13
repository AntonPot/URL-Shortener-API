class Access < ApplicationRecord
  belongs_to :link
  belongs_to :ip_country

  validates :address, :link_id, :ip_country_id, presence: true
end
