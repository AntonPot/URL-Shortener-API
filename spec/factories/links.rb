FactoryBot.define do
  factory :link do
    url { 'https://google.com' }
    slug { 'test_slug' }
    usage_counter { 1 }
  end
end
