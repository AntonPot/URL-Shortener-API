FactoryBot.define do
  factory :access do
    address { Faker::Internet.public_ip_v4_address }
  end
end
