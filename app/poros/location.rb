class Location
  attr_reader :lat_lon

  def initialize(data)
    @lat_lon = "#{data[:results][0][:locations][0][:latLng][:lat]},#{data[:results][0][:locations][0][:latLng][:lng]}"
  end
end