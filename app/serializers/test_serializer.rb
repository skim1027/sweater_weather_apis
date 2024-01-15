class TestSerializer 
  include JSONAPI::Serializer

  attributes :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def start_city
    @object.from
  end

  def end_city
    @object.to
  end

  def travel_time
    @object.total_travel_time
  end

  def weather_at_eta
    @object.weather
  end
end