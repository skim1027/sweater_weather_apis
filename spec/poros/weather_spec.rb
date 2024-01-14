require 'rails_helper'

RSpec.describe Weather do
  it 'exist' do
    attr = File.read('spec/fixtures/washington_dc.json')
    attr_json = JSON.parse(attr, symbolize_names: true)
    dc_weather = Weather.new(attr_json)
    expect(dc_weather).to be_a(Weather)
    expect(dc_weather.id).to eq(nil)
    expect(dc_weather.current_weather).to be_a(Hash)
    expect(dc_weather.current_weather[:last_updated]).to eq('2024-01-12 16:30')
    expect(dc_weather.current_weather[:temperature]).to eq(47.8)
    expect(dc_weather.daily_weather).to be_an(Array)
    expect(dc_weather.daily_weather[0][:sunrise]).to eq('07:27 AM')
    expect(dc_weather.daily_weather[0][:sunset]).to eq('05:07 PM')
    expect(dc_weather.hourly_weather).to be_an(Array)
    expect(dc_weather.hourly_weather[0][:time]).to eq('00:00')
    expect(dc_weather.hourly_weather[0][:temperature]).to eq(42.1)
  end
end