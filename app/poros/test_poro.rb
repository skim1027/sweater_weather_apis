class TestPoro
  attr_reader :from, :to, :total_travel_time, :weather
  def initialize(data)
    @id = nil
    @from = data[:from]
    @to = data[:to]
    @total_travel_time = data[:total_travel_time]
    @weather = data[:weather]
  end
end