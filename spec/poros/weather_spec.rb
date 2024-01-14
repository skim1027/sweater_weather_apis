require 'rails_helper'

RSpec.describe Weather do
  it 'exist' do
    attr = File.read('spec/fixtures/washington_dc.json')
    attr_json = JSON.parse(attr, symbolize_names: true)
    dc_weather = Weather.new(attr_json)
    expect(dc_weather).to be_a(Weather)
    expect(dc_weather.id).to eq(nil)
    expect(dc_weather.current_weather).to be_a(Hash)
    expect(dc_weather.daily_weather).to be_an(Array)
    expect(dc_weather.hourly_weather).to be_an(Array)
  end
end