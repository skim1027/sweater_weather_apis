class Api::V1::MunchiesController < ApplicationController

  def index
    destination= params[:destination]
    food = params[:food]

    weather = (WeatherFacade.new.location_weather(destination).munchies_weather)
    food_rec = (MunchiesFacade.new.food_rec(destination, food))

    render json: CombinedSerializer.data(food_rec, destination, weather), status: :ok
  end
end