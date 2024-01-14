class WeatherFacade
  def location_weather(lat_lon)
    data = WeatherService.new.weather(lat_lon)
    Weather.new(data)
  end
end