require 'rails_helper'

RSpec.describe CombinedSerializer do
  describe 'combined serializer' do
    it 'creates data with id, type and attributes' do
      weather = File.read('spec/fixtures/washington_dc.json')
      stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=5&key=#{Rails.application.credentials.weather[:key]}&q=Denver,CO").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: weather, headers: {})

      food = File.read('spec/fixtures/munchies.json')
      food_json = JSON.parse(food, symbolize_names: true)
      stub_request(:get, "https://api.yelp.com/v3/businesses/search?limit=20&location=Denver,CO&sort_by=best_match&term=Italian").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>"Bearer #{Rails.application.credentials.yelp[:key]}",
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: food, headers: {})

      destination = 'Denver,CO'
      type = 'Italian'
      weather = (WeatherFacade.new.location_weather(destination).munchies_weather)
      food_rec = (MunchiesFacade.new.food_rec(destination, type))

      serialized = CombinedSerializer.data(food_rec, destination, weather)

      expect(serialized[:data]).to have_key(:id)
      expect(serialized[:data]).to have_key(:type)
      expect(serialized[:data]).to have_key(:attributes)
      expect(serialized[:data][:type]).to eq("munchies")
      expect(serialized[:data][:attributes]).to have_key(:destination_city)
      expect(serialized[:data][:attributes]).to have_key(:forecast)
      expect(serialized[:data][:attributes]).to have_key(:restaurant)
      expect(serialized[:data][:attributes][:forecast]).to have_key(:summary)
      expect(serialized[:data][:attributes][:forecast]).to have_key(:temperature)
    end
  end
end