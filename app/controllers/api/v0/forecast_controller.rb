class Api::V0::ForecastController < ApplicationController
  def index
    location = params[:location]

    lat_lon = LocationFacade.new.city_state(location).lat_lon
    weather = WeatherSerializer.new(WeatherFacade.new.location_weather(lat_lon))

    render json: weather, status: :ok
  end
end