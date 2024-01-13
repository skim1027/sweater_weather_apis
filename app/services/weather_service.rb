class WeatherService
  def conn
    Faraday.new(url: 'http://api.weatherapi.com/') do |f|
      f.params[:key] = Rails.application.credentials.weather[:key]
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def weather(location)
    get_url("v1/forecast.json?q=#{location}&days=5")
  end
end