class Weather
  attr_reader :id
  def initialize(data)
    @data = data
    @id = nil
  end
  
  def current_weather
    current = {}
    
    current[:last_updated] = @data[:current][:last_updated]
    current[:temperature] = @data[:current][:temp_f]
    current[:feels_like] = @data[:current][:feelslike_f]
    current[:humidity] = @data[:current][:humidity]
    current[:uvi] = @data[:current][:uv]
    current[:visibility] = @data[:current][:vis_miles]
    current[:condition] = @data[:current][:condition][:text]
    current[:icon] = @data[:current][:condition][:icon]
    require 'pry'; binding.pry
  end
end