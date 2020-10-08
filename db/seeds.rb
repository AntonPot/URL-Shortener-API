marko = User.create!(email: 'marko@email.com', password: 'asdfasdf', password_confirmation: 'asdfasdf')
link = Link.create!(url: 'https://google.com', slug: 'google_slug', user: marko)
ip_country = IpCountry.create!(country_name: 'Germany')
access = Access.create!(address: '94.114.243.196', link: link, ip_country: ip_country)
