class TravelTime
  attr_reader :travel_time,
              :time_in_hrs

  def initialize(data)
    @travel_time = data[:route][:formattedTime]
    @time_in_hrs = data[:route][:time]/60/60
  end
end