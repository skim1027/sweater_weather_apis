require 'rails_helper'

RSpec.describe Location do
  it 'exist' do
    attr = {
      results: [
        {
          locations: [
            {
              latLng: {
                lat: 30,
                lng: 30
              }
            }
          ]
        }
      ]
    }

    location = Location.new(attr)

    expect(location).to be_a(Location)
    expect(location.lat_lon).to eq('30,30')
  end
end