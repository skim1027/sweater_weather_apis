require 'rails_helper'

describe 'session' do
  it 'logs you in with the correct email and password' do
    user = User.create(email: "whatever@example.com", password: "password")

    user_params = {
                    email: "whatever@example.com",
                    password: "password",
                  }
    headers = { 
                "CONTENT_TYPE" => "application/json",
                "ACCEPT" => "application/json"
              }

    post '/api/v0/sessions', headers: headers, params: user_params.to_json

    user_info = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response.status).to eq(200)

    expect(user_info).to have_key(:id)
    expect(user_info).to have_key(:type)
    expect(user_info).to have_key(:attributes)
    expect(user_info[:attributes]).to have_key(:email)
    expect(user_info[:attributes][:email]).to eq(user.email)
    expect(user_info[:attributes]).to have_key(:api_key)
    expect(user_info[:attributes][:api_key]).to eq(user.api_key)
    expect(user_info[:attributes]).to_not have_key(:password)
  end

  it 'gives you an error if your credentials are bad' do
    User.create(email: "whatever@example.com", password: "password")

    user_params = {
                    email: "whatever@example.com",
                    password: "wrongpassword",
                  }
    headers = { 
                "CONTENT_TYPE" => "application/json",
                "ACCEPT" => "application/json"
              }

    post '/api/v0/sessions', headers: headers, params: user_params.to_json

    user_info = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)

    user_info = JSON.parse(response.body, symbolize_names: true)
    expect(user_info[:errors].first[:status]).to eq("400")
    expect(user_info[:errors].first[:title]).to eq("Please put correct email and password")
  end
end