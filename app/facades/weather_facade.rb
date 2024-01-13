class WeatherFacade
  def location_weather(lat_lon)
    WeatherService.new.weather(lat_lon)
  end
end