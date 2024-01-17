require 'rails_helper'

describe LocationService do
  describe 'city_state' do
    it 'returns location data from city and state' do
      lat_lon_data = File.read('spec/fixtures/city_state.json')
        stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?key=#{Rails.application.credentials.mapquest[:key]}&location=Washington,DC").
        with(
          headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v2.9.0'
          }).
        to_return(status: 200, body: lat_lon_data, headers: {})

      wash_dc = LocationService.new.city_state('Washington,DC')

      expect(wash_dc).to be_a(Hash)
      expect(wash_dc).to have_key(:info)
      expect(wash_dc).to have_key(:options)
      expect(wash_dc).to have_key(:results)
      
      wash_dc_results = wash_dc[:results][0]
      
      expect(wash_dc_results).to have_key(:locations)
      expect(wash_dc_results[:locations][0]).to have_key(:latLng)
      expect(wash_dc_results[:locations][0][:latLng]).to have_key(:lat)
      expect(wash_dc_results[:locations][0][:latLng]).to have_key(:lng)
      expect(wash_dc_results[:locations][0][:latLng][:lat]).to eq(38.89037)
      expect(wash_dc_results[:locations][0][:latLng][:lng]).to eq(-77.03196)
    end

    it 'gives you directions' do
      directions_data = File.read('spec/fixtures/directions.json')
      stub_request(:get, "https://www.mapquestapi.com/directions/v2/route?from=Denver,CO&key=#{Rails.application.credentials.mapquest[:key]}&to=Oregon,WA").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: directions_data, headers: {})
      directions = LocationService.new.directions('Denver,CO', 'Oregon,WA')

      expect(directions).to be_a(Hash)
      expect(directions.keys).to match_array([:route, :info])
      expect(directions[:route]).to be_a(Hash)
      expect(directions[:route]).to have_key(:formattedTime)
      expect(directions[:route]).to have_key(:time)
    end
  end
end