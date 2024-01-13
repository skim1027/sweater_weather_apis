class Api::V0::ForecastController < ApplicationController
  def index
    location = params[:location]

    lat_lon = LocationFacade.new.city_state(location).lat_lon
    # WeatherFacade.new.location_weather(location)

  # require 'pry'; binding.pry    
  end
end