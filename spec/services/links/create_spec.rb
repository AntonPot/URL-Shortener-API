require 'rails_helper'

RSpec.describe Links::Create, type: :service do
  let(:user) { create :user }
  let(:url) { 'https://google.com' }
  let(:slug) { 'slug1' }
  let(:arguments) { {url: url, slug: slug, user: user } }

  subject(:service) { Links::Create.run(arguments) }

  context 'when successful' do
    it 'creates a new Link' do
      expect { service }.to change(Link, :count).by(1)
    end

    it 'responds truthfuly on successful?' do
      expect(service.successful?).to be true
    end

    it 'responds with successful alert message' do
      expect(service.alert_message).to eq 'Link successfuly created'
    end
  end

  context 'when unsuccesful' do
    let(:link) { create :link, url: url }

    before { link.update(user: user) }

    it 'does not create a new Link' do
      expect { service }.to change(Link, :count).by(0)
    end

    it 'responds falsefuly on successful?' do
      expect(service.successful?).to be false
    end

    it 'responds with error message' do
      expect(service.alert_message).to eq 'Url is already in DB'
    end
  end
end
