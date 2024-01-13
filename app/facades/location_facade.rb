class LocationFacade 
  def city_state(location)
    data = LocationService.new.city_state(location)
    Location.new(data)
  end
end