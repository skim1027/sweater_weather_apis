class RoadTripSerializer
  include JSONAPI::Serializer

  def self.data(weather, total_travel_time, from, to)
    {
      data: {
        id: 'null',
        type: 'road_trip',
        attributes: {
          start_city: from,
          end_city: to,
          travel_time: total_travel_time,
          weather_at_eta: weather
        }
      }
    }
  end

end