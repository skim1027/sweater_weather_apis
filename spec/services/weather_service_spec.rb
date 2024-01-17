require 'rails_helper'

describe WeatherService do
  describe 'weather' do
    it 'returns weather data from location' do
      weather_data = File.read('spec/fixtures/washington_dc.json')
      stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=5&key=#{Rails.application.credentials.weather[:key]}&q=38.89037,-77.03196").
        with(
          headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v2.9.0'
          }).
        to_return(status: 200, body: weather_data, headers: {})
      weather = WeatherService.new.weather('38.89037,-77.03196')

      expect(weather).to be_a(Hash)
      expect(weather).to have_key(:location)
      expect(weather).to have_key(:current)
      expect(weather).to have_key(:forecast)
      expect(weather).to have_key(:location)
    end
  end
end