FactoryBot.define do
  factory :access do
    before(:create) do |access, _|
      access.link = create(:link)
      access.ip_country = create(:ip_country)
    end
    address { Faker::Internet.public_ip_v4_address }
  end
end
