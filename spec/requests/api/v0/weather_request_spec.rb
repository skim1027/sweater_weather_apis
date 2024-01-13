require 'rails_helper'

describe 'weather API' do
  it 'sends api data for the city' do

    get '/api/v0/forecast?location=cincinatti,oh'

    forecast = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(response).to be_successful

    expect(forecast).to have_key(:id)
    expect(forecast[:id]).to be_null 

    expect(forecast).to have_key(:type)
    expect(forecast[:type]).to be_a(String)

    expect(forecast).to have_key(:attributes)
    expect(forecast[:attributes]).to be_a(Hash)

    forecast_att = forecast[:attributes]

    expect(forecast_att).to have_key(:current_weather)
    expect(forecast_att).to have_key(:daily_weather)
    expect(forecast_att).to have_key(:hourly_weather)
  end
end