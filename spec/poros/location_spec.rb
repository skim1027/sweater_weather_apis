require 'rails_helper'

RSpec.describe Location do
  it 'exist' do
    attr = File.read('spec/fixtures/city_state.json')
    attr_json = JSON.parse(attr, symbolize_names: true)
    location = Location.new(attr_json)

    expect(location).to be_a(Location)
    expect(location.lat_lon).to eq('38.89037,-77.03196')
  end
end