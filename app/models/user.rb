class User < ApplicationRecord
  has_secure_password

  has_many :links, dependent: :delete_all

  validates :email, presence: true
  validates :email, uniqueness: true

  def username
    email.split('@').first
  end
end
