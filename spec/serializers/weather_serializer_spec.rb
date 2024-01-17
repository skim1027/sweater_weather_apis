require 'rails_helper'

RSpec.describe WeatherSerializer do
  describe 'weather serializer' do
    it 'create data with id, type and attributes' do
      weather = File.read('spec/fixtures/washington_dc.json')
      weather_json = JSON.parse(weather, symbolize_names: true)
      stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=5&key=#{Rails.application.credentials.weather[:key]}&q=38.89037,-77.03196").
        with(
          headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v2.9.0'
          }).
        to_return(status: 200, body: weather, headers: {})
      
      lat_lon = '38.89037,-77.03196'
      weather_poro = WeatherFacade.new.location_weather(lat_lon)
      serialized = WeatherSerializer.new(weather_poro).serializable_hash
      expect(serialized[:data]).to have_key(:id)
      expect(serialized[:data]).to have_key(:type)
      expect(serialized[:data]).to have_key(:attributes)
      expect(serialized[:data][:type]).to eq(:forecast)
      expect(serialized[:data][:attributes][:daily_weather].count).to eq(5)
      expect(serialized[:data][:attributes][:hourly_weather].count).to eq(24)
    end
  end
end

