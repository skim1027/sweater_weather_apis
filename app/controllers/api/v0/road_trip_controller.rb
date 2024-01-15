class Api::V0::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      lat_lon = LocationFacade.new.city_state(params[:destination]).lat_lon
      total_travel_time = LocationFacade.new.directions(params[:origin], params[:destination]).travel_time
      hours = LocationFacade.new.directions(params[:origin], params[:destination]).time_in_hrs
      eta_time = (DateTime.now + hours.hours).strftime("%Y-%m-%d %H")
      

      require 'pry'; binding.pry
    end
  end
end