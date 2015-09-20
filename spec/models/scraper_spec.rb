require 'rails_helper'

describe Scraper do
  describe '.scrape_all' do
    before(:each) do
      stub_request(:get, Scraper::URL)
        .to_return(body: File.read('spec/webmock_fixtures/bookings.html'))
    end

    it 'makes a web request' do
      Scraper.scrape_all
      expect(a_request(:get, Scraper::URL)).to have_been_made.once
    end

    it 'creates an arrest' do
      expect { Scraper.scrape_all }.to change{ Arrest.count }.by(1)
    end

    it 'creates charges' do
      expect { Scraper.scrape_all }.to change{ Charge.count }.by(3)
    end

    it 'creates charge_types' do
      expect { Scraper.scrape_all }.to change{ ChargeType.count }.by(3)
    end
  end
end

