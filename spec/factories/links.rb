FactoryBot.define do
  factory :link do
    before(:build, :create) do |link, _|
      link.user = create(:user)
    end

    url { 'https://google.com' }
    sequence(:slug) { |n| "slug#{n}" }
  end
end
