class Api::V1::MunchiesController < ApplicationController

  def index
    destination= params[:destination]
    food = params[:food]

    weather = WeatherSerializer.new(WeatherFacade.new.location_weather(destination).munchies_weather)
    x = MunchiesSerializer.new(MunchiesFacade.new.food_rec(destination, food))
    
    require 'pry'; binding.pry
    CombinedSerializer.new(weather.resource, x.resource)
  end
end