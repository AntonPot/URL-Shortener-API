json.array!(@links) do |link|
  json.id(link.id)
  json.url(link.url)
  json.short_url(link.short_url)
  json.access_count(link.access_count)
  json.countries_count(link.countries_count)
  json.user_email(link.user_email)
end
