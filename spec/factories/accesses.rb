FactoryBot.define do
  factory :access do
    before(:create) do |access, _|
      access.link = Link.create(url: Faker::Internet.url)
      access.ip_country = IpCountry.create(country_name: 'Germany', country_code: 'DE', country_emoji: '🇩🇪')
    end
    address { Faker::Internet.public_ip_v4_address }
  end
end
