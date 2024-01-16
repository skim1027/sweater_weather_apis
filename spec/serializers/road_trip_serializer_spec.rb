require 'rails_helper'

RSpec.describe RoadTripSerializer do
  describe 'road trip serializer' do
    it 'create data with id, type and attributes' do
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
      stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=5&key=#{Rails.application.credentials.weather[:key]}&q=22,44").
      with(
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: weather, headers: {})
      weather = WeatherFacade.new.location_weather('22,44').weather_at_eta('2024-01-14 06')
      trip = RoadTripSerializer.data(weather, '01:20:00', 'Denver,CO', 'Oregon,WA')
      
      expect(trip).to be_a(Hash)
      expect(trip).to have_key(:data)
      expect(trip[:data].keys).to match_array([:id, :type, :attributes])
      expect(trip[:data][:attributes].keys).to match_array([:start_city, :end_city, :travel_time, :weather_at_eta])
    end

    it 'has serializer for impossible routes' do
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
      stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=5&key=#{Rails.application.credentials.weather[:key]}&q=22,44").
      with(
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: weather, headers: {})
      weather = WeatherFacade.new.location_weather('22,44').weather_at_eta('2024-01-14 06')
      trip = RoadTripSerializer.impossible('Denver,CO', 'London,UK')
      
      expect(trip).to be_a(Hash)
      expect(trip).to have_key(:data)
      expect(trip[:data].keys).to match_array([:id, :type, :attributes])
      expect(trip[:data][:attributes].keys).to match_array([:start_city, :end_city, :travel_time, :weather_at_eta])
      expect(trip[:data][:attributes][:travel_time]).to eq('impossible')
      expect(trip[:data][:attributes][:weather_at_eta]).to eq([])
    end
  end
end