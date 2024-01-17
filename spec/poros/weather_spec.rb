require 'rails_helper'

RSpec.describe Weather do
  before:each do
    attr = File.read('spec/fixtures/washington_dc.json')
    attr_json = JSON.parse(attr, symbolize_names: true)
    @dc_weather = Weather.new(attr_json)
  end

  it 'exist' do
    expect(@dc_weather).to be_a(Weather)
    expect(@dc_weather.id).to eq(nil)
  end
  
  it 'has current weather info' do
    expect(@dc_weather.current_weather).to be_a(Hash)
    expect(@dc_weather.current_weather[:last_updated]).to eq('2024-01-12 16:30')
    expect(@dc_weather.current_weather[:temperature]).to eq(47.8)
  end
  
  it 'has daily weather info' do
    expect(@dc_weather.daily_weather).to be_an(Array)
    expect(@dc_weather.daily_weather[0][:sunrise]).to eq('07:27 AM')
    expect(@dc_weather.daily_weather[0][:sunset]).to eq('05:07 PM')
  end
  
  it 'has hourly weather info' do
    expect(@dc_weather.hourly_weather).to be_an(Array)
    expect(@dc_weather.hourly_weather[0][:time]).to eq('00:00')
    expect(@dc_weather.hourly_weather[0][:temperature]).to eq(42.1)
  end

  it 'has weather at eta' do
    expect(@dc_weather.weather_at_eta('2024-01-15 05')).to be_a(Hash)
    expect(@dc_weather.weather_at_eta('2024-01-15 05')).to have_key(:datetime)
    expect(@dc_weather.weather_at_eta('2024-01-15 05')).to have_key(:temperature)
    expect(@dc_weather.weather_at_eta('2024-01-15 05')).to have_key(:condition)

  end
end