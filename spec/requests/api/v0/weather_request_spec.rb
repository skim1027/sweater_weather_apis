require 'rails_helper'

describe 'weather API' do
  it 'sends api data for the city' do
    city_state_json = File.read('spec/fixtures/city_state.json')
    stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?key=#{Rails.application.credentials.mapquest[:key]}&location=cincinatti,oh").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: city_state_json, headers: {})

    get '/api/v0/forecast?location=cincinatti,oh'

    forecast = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(response).to be_successful

    expect(forecast).to have_key(:id)
    expect(forecast[:id]).to be_null 

    expect(forecast).to have_key(:type)
    expect(forecast[:type]).to be_a(String)

    expect(forecast).to have_key(:attributes)
    expect(forecast[:attributes]).to be_a(Hash)

    forecast_att = forecast[:attributes]

    expect(forecast_att).to have_key(:current_weather)
    expect(forecast_att).to have_key(:daily_weather)
    expect(forecast_att).to have_key(:hourly_weather)
  end
end