require 'rails_helper'

describe WeatherFacade do
  context 'location_weather' do
    it 'gives current weather daily weather and hourly weather data' do
      weather_data = File.read('spec/fixtures/washington_dc.json')
      stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=5&key=#{Rails.application.credentials.weather[:key]}&q=38.89037,-77.03196").
        with(
          headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v2.9.0'
          }).
        to_return(status: 200, body: weather_data, headers: {})
      dc_weather = WeatherFacade.new.location_weather('38.89037,-77.03196')

      expect(dc_weather.id).to eq(nil)
      expect(dc_weather.current_weather).to be_a(Hash)
      require 'pry'; binding.pry
      expect(dc_weather.daily_weather).to be_an(Array)
    end
  end
end