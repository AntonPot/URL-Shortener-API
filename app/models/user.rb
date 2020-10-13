class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  has_many :links, dependent: :delete_all

  def username
    email.split('@').first
  end
end
