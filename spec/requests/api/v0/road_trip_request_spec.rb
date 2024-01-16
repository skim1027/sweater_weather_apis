require 'rails_helper'

describe 'road_trip' do
  it 'returns id, type, attributes with start&end city, travel time and weather at eta' do
    directions = File.read('spec/fixtures/directions.json')
    stub_request(:get, "https://www.mapquestapi.com/directions/v2/route?from=Denver,CO&key=#{Rails.application.credentials.mapquest[:key]}&to=Oregon,WA").
    with(
      headers: {
    'Accept'=>'*/*',
    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: directions, headers: {})
    lat_lon = File.read('spec/fixtures/city_state.json')
    stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?key=#{Rails.application.credentials.mapquest[:key]}&location=Oregon,WA").
    with(
      headers: {
    'Accept'=>'*/*',
    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: lat_lon, headers: {})
    weather = File.read('spec/fixtures/washington_dc.json')
    stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=5&key=8361d3424a244c8a891212331241201&q=38.89037,-77.03196").
    with(
      headers: {
    'Accept'=>'*/*',
    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: weather, headers: {})

    user = User.create(email: "whatever@example.com", password: "password")
    request = {
      origin: 'Denver,CO',
      destination: 'Oregon,WA',
      api_key: user.api_key
    }

    headers = { 
      "CONTENT_TYPE" => "application/json",
      "ACCEPT" => "application/json"
    }

    post '/api/v0/road_trip', headers: headers, params: request.to_json
    expect(response.status).to eq(200)

    trip_info = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(trip_info).to have_key(:id)
    expect(trip_info).to have_key(:type)
    expect(trip_info).to have_key(:attributes)
    expect(trip_info[:attributes]).to have_key(:start_city)
    expect(trip_info[:attributes]).to have_key(:end_city)
    expect(trip_info[:attributes]).to have_key(:travel_time)
    expect(trip_info[:attributes]).to have_key(:weather_at_eta)
    expect(trip_info[:attributes][:weather_at_eta]).to be_a Hash
  end

  it 'gives you an empty weather and impossible travel time if route is impossible' do
    directions = File.read('spec/fixtures/london.json')

    stub_request(:get, "https://www.mapquestapi.com/directions/v2/route?from=Denver,CO&key=#{Rails.application.credentials.mapquest[:key]}&to=London,UK").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: directions, headers: {})
    lat_lon = File.read('spec/fixtures/city_state.json')
    stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?key=#{Rails.application.credentials.mapquest[:key]}&location=London,UK").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: lat_lon, headers: {})
    weather = File.read('spec/fixtures/washington_dc.json')
    stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=5&key=8361d3424a244c8a891212331241201&q=38.89037,-77.03196").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: weather, headers: {})

    user = User.create(email: "whatever@example.com", password: "password")
    request = {
      origin: 'Denver,CO',
      destination: 'London,UK',
      api_key: user.api_key
    }

    headers = { 
      "CONTENT_TYPE" => "application/json",
      "ACCEPT" => "application/json"
    }

    post '/api/v0/road_trip', headers: headers, params: request.to_json
    expect(response.status).to eq(200)

    trip_info = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(trip_info[:attributes][:travel_time]).to eq('impossible')
    expect(trip_info[:attributes][:weather_at_eta]).to eq([])
  end

  it 'gives you error if incorrect or no api_key is given' do
    directions = File.read('spec/fixtures/directions.json')

    stub_request(:get, "https://www.mapquestapi.com/directions/v2/route?from=Denver,CO&key=#{Rails.application.credentials.mapquest[:key]}&to=Oregon,WA").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: directions, headers: {})
    lat_lon = File.read('spec/fixtures/city_state.json')
    stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?key=#{Rails.application.credentials.mapquest[:key]}&location=Oregon,WA").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: lat_lon, headers: {})
    weather = File.read('spec/fixtures/washington_dc.json')
    stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=5&key=8361d3424a244c8a891212331241201&q=38.89037,-77.03196").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: weather, headers: {})

    user = User.create(email: "whatever@example.com", password: "password")
    request = {
      origin: 'Denver,CO',
      destination: 'Oregon,WA',
      api_key: 'fake_key'
    }

    headers = { 
      "CONTENT_TYPE" => "application/json",
      "ACCEPT" => "application/json"
    }

    post '/api/v0/road_trip', headers: headers, params: request.to_json

    expect(response.status).to eq(401)

    trip_info = JSON.parse(response.body, symbolize_names: true)

    expect(trip_info[:errors].first[:title]).to eq("Please provide correct API key")
  end


end