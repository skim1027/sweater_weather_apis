class MunchiesService
  def conn
    Faraday.new(url: 'https://api.yelp.com/') do |f|
      f.headers['Authorization'] = "Bearer #{Rails.application.credentials.yelp[:key]}"
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def food_rec(location, type)
    get_url("v3/businesses/search?location=#{location}&term=#{type}&sort_by=best_match&limit=20")
  end
end