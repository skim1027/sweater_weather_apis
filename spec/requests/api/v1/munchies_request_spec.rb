require 'rails_helper'

RSpec.describe 'munchies API', type: :request do
  it 'sends api data for the destination city with forecast and restaurant' do
    pueblo = File.read('spec/fixtures/pueblo.json')
    stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=5&key=#{Rails.application.credentials.weather[:key]}&q=pueblo,co").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: pueblo, headers: {})
    food = File.read('spec/fixtures/munchies.json')
    stub_request(:get, "https://api.yelp.com/v3/businesses/search?limit=20&location=pueblo,co&sort_by=best_match&term=italian").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>"Bearer #{Rails.application.credentials.yelp[:key]}",
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: food, headers: {})
    
    get '/api/v1/munchies?destination=pueblo,co&food=italian'

    restaurant = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(response).to be_successful

    expect(restaurant).to have_key(:id)
    expect(restaurant).to have_key(:type)
    expect(restaurant).to have_key(:attributes)
    expect(restaurant[:attributes]).to have_key(:destination_city)
    expect(restaurant[:attributes]).to have_key(:forecast)
    expect(restaurant[:attributes]).to have_key(:restaurant)
  end
end