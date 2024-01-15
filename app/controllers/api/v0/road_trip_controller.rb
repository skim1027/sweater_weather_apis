class Api::V0::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    from = params[:origin]
    to = params[:destination]
    if user
      lat_lon = LocationFacade.new.city_state(to).lat_lon
      total_travel_time = LocationFacade.new.directions(from, to).travel_time
      hours = LocationFacade.new.directions(from, to).time_in_hrs
      eta_time = (DateTime.now + hours.hours).strftime("%Y-%m-%d %H")
      weather = WeatherFacade.new.location_weather(lat_lon).weather_at_eta
      x = TestPoro.new({from: from, to: to, total_travel_time: total_travel_time, weather: weather})

      render json: TestSerializer.new(x), status: :ok
    end
  end
end