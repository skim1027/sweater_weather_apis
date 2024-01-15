require 'rails_helper'

describe MunchiesFacade do
  describe 'food_rec' do
    it 'returns restaurant poro with name, address, rating and reviews' do
      munchies = File.read('spec/fixtures/munchies.json')
      stub_request(:get, "https://api.yelp.com/v3/businesses/search?limit=20&location=Denver&sort_by=best_match&term=Italian").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'Authorization'=>"Bearer #{Rails.application.credentials.yelp[:key]}",
       'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: munchies, headers: {})
      data = MunchiesFacade.new.food_rec('Denver', 'Italian')

      expect(data.name).to eq('Odyssey Italian Restaurant')
      expect(data.reviews).to eq(1313)
      expect(data.rating).to eq(4.5)
      expect(data.address).to eq('603 E 6th Ave, Denver, CO 80203')
    end
  end
end