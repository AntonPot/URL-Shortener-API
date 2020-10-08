ip_address = '94.114.243.196'

link = Link.create!(url: 'https://google.com', slug: 'google_slug')
ip_country = IpCountry.create!(address: ip_address, country_name: 'Germany')
access = Access.create!(address: ip_address, link: link, ip_country: ip_country)
