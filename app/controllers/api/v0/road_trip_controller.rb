class Api::V0::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    from = params[:origin]
    to = params[:destination]
    if user
      # lat_lon = LocationFacade.new.city_state(to).lat_lon
      # total_travel_time = LocationFacade.new.directions(from, to).travel_time
      # hours = LocationFacade.new.directions(from, to).time_in_hrs
      # eta_time = (DateTime.now + hours.hours).strftime("%Y-%m-%d %H")
      # weather = WeatherFacade.new.location_weather(lat_lon).weather_at_eta(eta_time)
      render json: RoadTripSerializer.data(weather(lat_lon(to), hours(from, to)), total_travel_time(from, to), from, to), status: :ok
    else
      render json: { errors: [title: "Please provide correct API key", status: "400"] }, status: :bad_request
    end
  end

  # if user is not there, return error, direction !=, then error, 

  private

  def lat_lon(location)
    LocationFacade.new.city_state(location).lat_lon
  end

  def total_travel_time(from, to)
    LocationFacade.new.directions(from, to).travel_time
  end

  def hours(from, to)
    LocationFacade.new.directions(from, to).time_in_hrs
  end

  def weather(lat_lon, hrs)
    WeatherFacade.new.location_weather(lat_lon).weather_at_eta(eta_time(hrs))
  end
  
  def eta_time(hours)
    (DateTime.now + hours.hours).strftime("%Y-%m-%d %H")
  end
end