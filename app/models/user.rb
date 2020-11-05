class User < ApplicationRecord
  has_many :links, dependent: :delete_all

  def username
    email.split('@').first
  end
end
