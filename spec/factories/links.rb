FactoryBot.define do
  factory :link do
    before(:create) do |link, _|
      link.user = create(:user)
    end

    url { 'https://google.com' }
    sequence(:slug) { |n| "test_slug-#{n}" }
  end
end
