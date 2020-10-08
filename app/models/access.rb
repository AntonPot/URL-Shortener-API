class Access < ApplicationRecord
  belongs_to :link
  belongs_to :ip_country
end
