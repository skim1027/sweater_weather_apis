class CombinedSerializer
  include JSONAPI::Serializer

  def weather 
    WeatherSerializer.new(WeatherFacade.new.location_weather(destination).munchies_weather)
  end

  def munchies
    MunchiesSerializer.new(MunchiesFacade.new.food_rec(destination, food))
  end
end