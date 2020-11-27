Rails.application.config.middleware.insert_before 0, Rack::Cors do
  # NOTE: Exposing headers to get filename
  # https://glaucocustodio.github.io/2016/01/20/dont-forget-to-expose-headers-when-using-rack-cors/
  allow do
    origins 'http://localhost:3000'
    resource '*',
      headers: :any,
      methods: [:get, :post, :patch, :put, :delete, :options, :head],
      credentials: true,
      expose: 'Content-Disposition'
  end

  # allow do
  #   origins 'https://add-production-domain-here.com'
  #   resource '*', headers: :any, methods: [:get, :post, :patch, :put, :delete, :options, :head], credentials: true
  # end
end
