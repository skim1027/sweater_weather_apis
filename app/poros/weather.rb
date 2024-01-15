class Weather
  attr_reader :id, :data
  def initialize(data)
    @data = data
    @id = nil
  end
  
  def current_weather
    current = {}
    current[:last_updated] = @data[:current] [:last_updated]
    current[:temperature] = @data[:current] [:temp_f]
    current[:feels_like] = @data[:current] [:feelslike_f]
    current[:humidity] = @data[:current] [:humidity]
    current[:uvi] = @data[:current] [:uv]
    current[:visibility] = @data[:current] [:vis_miles]
    current[:condition] = @data[:current] [:condition][:text]
    current[:icon] = @data[:current] [:condition][:icon]
    current
  end

  def daily_weather
    daily = []
    @data[:forecast][:forecastday].each do |day|
      daily << {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon],
    }
    end
    daily
  end

  def hourly_weather
    hourly = []
    @data[:forecast][:forecastday][0][:hour].each do |each_hr|
      hourly << {
        time: DateTime.parse(each_hr[:time]).strftime("%H:%M"),
        temperature: each_hr[:temp_f],
        conditions: each_hr[:condition][:text],
        icon: each_hr[:condition][:icon]
      }
    end
    hourly
  end

  def weather_at_eta(hrs)
    temp = nil
    condition = nil
    new_hrs = hrs + ":00"
    @data[:forecast][:forecastday].each do |day, value|
      if new_hrs.include?(day[:date]) 
        day[:hour].each do |each|
          if new_hrs == each[:time] 
            temp = each[:temp_f]
            condition = each[:condition][:text]
          end
        end
      end
    end
    temp
    condition
    weather_data = {
      datetime: new_hrs,
      temperate: temp,
      condition: condition
    }
  end
end
