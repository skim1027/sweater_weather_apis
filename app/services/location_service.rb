class LocationService
  def conn
    Faraday.new(url: 'https://www.mapquestapi.com/')
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def city_state(location)
    get_url("geocoding/v1/address?key=#{Rails.application.credentials.mapquest[:key]}&location=#{location}")
  end
end