require 'rails_helper'

describe MunchiesService do
  describe 'food rec' do
    it 'returns food match based on location' do
      food = File.read('spec/fixtures/munchies.json')
      stub_request(:get, "https://api.yelp.com/v3/businesses/search?limit=20&location=Pueblo,CO&sort_by=best_match&term=Italian").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'Authorization'=>"Bearer #{Rails.application.credentials.yelp[:key]}",
       'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: food, headers: {})
      food_rec = MunchiesService.new.food_rec('Pueblo,CO', 'Italian')

      expect(food_rec).to be_a(Hash)
      expect(food_rec).to have_key(:businesses)
      expect(food_rec[:businesses]).to be_an(Array)
      expect(food_rec[:businesses][0]).to have_key(:name)
      expect(food_rec[:businesses][0]).to have_key(:rating)
      expect(food_rec[:businesses][0]).to have_key(:review_count)
      expect(food_rec[:businesses][0]).to have_key(:location)
    end
  end

end