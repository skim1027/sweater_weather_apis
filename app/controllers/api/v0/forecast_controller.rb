class Api::V0::ForecastController < ApplicationController
  def index
    location = params[:location]

    lat_lon = LocationFacade.new.city_state(location)

    
  end
end