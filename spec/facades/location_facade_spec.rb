require 'rails_helper'

describe LocationFacade do
  context 'city_state' do
    it 'list lon/lng of the city/state' do
      location_data = File.read('spec/fixtures/city_state.json')
      stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?key=#{Rails.application.credentials.mapquest[:key]}&location=Washington,DC").
        with(
          headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v2.9.0'
          }).
        to_return(status: 200, body: location_data, headers: {})

      location = LocationFacade.new.city_state('Washington,DC')

      expect(location.lat_lon).to eq('38.89037,-77.03196')
    end

    it 'gives direction from/to' do
      directions_data = File.read('spec/fixtures/directions.json')
      stub_request(:get, "https://www.mapquestapi.com/directions/v2/route?from=Denver,CO&key=#{Rails.application.credentials.mapquest[:key]}&to=Oregon,WA").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: directions_data, headers: {})
      direction = LocationFacade.new.directions('Denver,CO', 'Oregon,WA')
      expect(direction.travel_time).to eq('18:19:25')
      expect(direction.time_in_hrs).to eq(18)
    end
  end
end