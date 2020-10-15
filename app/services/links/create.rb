# NOTE: I like having services namespaced with ActiveRecord method names to make
# controllers more concise and readable. It also helps avoiding model callbacks
# which can quickly get out of hand.
# Written this way, it's much clearer what is going on and when.

module Links
  class Create
    def self.run(args)
      service = new(args[:user], args[:url], args[:slug])
      service.link

      service
    end

    attr_reader :user, :url, :slug

    def initialize(user, url, slug)
      @user = user
      @url = url
      @slug = slug
    end

    def link
      @link ||= user.links.create(url: url, slug: slug)
    end

    def alert_message
      successful? ? 'Link successfuly created' : link.errors.full_messages.join('. ')
    end

    def successful?
      link.persisted?
    end
  end
end
