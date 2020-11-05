require 'rails_helper'

RSpec.describe Link, type: :model do
  let(:link) { create :link }
  let(:user) { create :user }

  it { is_expected.to respond_to :accesses, :ip_countries, :user }
  it { is_expected.to have_many :accesses }
  it { is_expected.to have_many :ip_countries }
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of :url }
  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_length_of(:slug).is_at_most(10) }

  context 'when URL structure is invalid' do
    invalid_examples = ['http:/banana.com', 'http//banana.com', 'http:banana.com']

    invalid_examples.each do |ie|
      it "rejects \"#{ie}\" as URL" do
        subject.url = ie
        expect(subject).not_to be_valid
        expect(subject.errors.messages[:url]).to include 'is not a valid URL'
      end
    end
  end

  context 'when slug format is invalid' do
    invalid_examples = ['foo bar1', 'foo-bar1', 'foo_bar1']

    invalid_examples.each do |ie|
      it "rejects \"#{ie}\" as slug" do
        subject.slug = ie
        expect(subject).not_to be_valid
        expect(subject.errors.messages[:slug]).to include 'invalid characters entered'
      end
    end
  end

  context 'when URL is not unique for specific user' do
    let(:url) { 'http://google.com' }

    it 'rejects URL' do
      link.update!(user: user, url: url)
      subject.user = user
      subject.url = url

      expect(subject).not_to be_valid
      expect(subject.errors.messages[:url]).to include 'is already in DB'
    end
  end

  context 'before validation is called' do
    it 'calls #assign_slug' do
      allow(subject).to receive(:assign_slug)
      subject.valid?
      expect(subject).to have_received(:assign_slug)
    end

    it 'assigns new slug if empty' do
      subject.slug = nil
      expect { subject.valid? }.to change(subject, :slug).from(nil)
    end

    it 'assigns new slug if slug is not unique' do
      create :link, slug: 'foobar'
      subject.slug = 'foobar'
      expect { subject.valid? }.to change(subject, :slug).from('foobar')
    end

    it 'does nothing if slug is present, but unique' do
      subject.slug = 'foobar'
      expect { subject.valid? }.not_to change(subject, :slug).from('foobar')
    end
  end

  describe 'scope :with_access_count' do
    let(:ip_country) { create :ip_country }
    let!(:access) { create :access, ip_country: ip_country, link: link }
    let(:scoped_link) { Link.with_access_count.first }

    it 'returns access_count attributes' do
      expect(scoped_link.attributes.keys).to include('access_count')
    end

    it 'counts accesses' do
      expect(scoped_link.access_count).to be(1)
    end
  end

  describe 'scope :with_countries_count' do
    let(:ip_country) { create :ip_country }
    let!(:access) { create :access, ip_country: ip_country, link: link }
    let(:scoped_link) { Link.with_countries_count.first }

    it 'returns countries_count attributes' do
      expect(scoped_link.attributes.keys).to include('countries_count')
    end

    it 'counts accesses' do
      expect(scoped_link.countries_count).to be(1)
    end
  end

  describe 'scope :with_user_email' do
    let(:scoped_link) { Link.with_user_email.first }

    before { link.update(user: user) }

    it 'returns user_email attribute' do
      expect(scoped_link.attributes.keys).to include('user_email')
    end

    it 'returns correct user email' do
      expect(scoped_link.user_email).to eq user.email
    end
  end
end
