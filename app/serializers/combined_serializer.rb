class CombinedSerializer

  def self.data(restaurant, destination, weather)
  {
    data: {
      id: 'null',
      type: 'munchies',
      attributes: {
        destination_city: destination,
        forecast: weather,
        restaurant: restaurant
      }
    }
  }

  end
end