class Api::V1::MunchiesController < ApplicationController

  def index
    destination= params[:destination]
    food = params[:food]

    MunchiesFacade.new.food_rec(destination, food)    
  end
end