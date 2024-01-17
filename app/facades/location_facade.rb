class LocationFacade 
  def city_state(location)
    data = LocationService.new.city_state(location)
    Location.new(data)
  end

  def directions(from, to)
    data = LocationService.new.directions(from, to)
    TravelTime.new(data)
  end
end