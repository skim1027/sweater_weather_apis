require 'rails_helper'

describe 'user registration' do
  it 'creates a user with post info' do

    user_params = {
                    email: "whatever@example.com",
                    password: "password",
                    password_confirmation: "password"
                  }
    headers = { "CONTENT_TYPE" => "application/json",
                "ACCEPT" => "application/json"
              }
  
    post '/api/v0/users', headers: headers, params: user_params.to_json

    user_info = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response.status).to eq(201)

    expect(user_info).to have_key(:id)
    expect(user_info).to have_key(:type)
    expect(user_info).to have_key(:attributes)
    expect(user_info[:attributes]).to have_key(:email)
    expect(user_info[:attributes]).to have_key(:api_key)
    expect(user_info[:attributes]).to_not have_key(:password)
  end

  it 'does not create a new user if you are already registered' do
    user_params = {
                    email: "whatever@example.com",
                    password: "password",
                    password_confirmation: "password"
                  }
    headers = { "CONTENT_TYPE" => "application/json",
                "ACCEPT" => "application/json"
              }
  
    post '/api/v0/users', headers: headers, params: user_params.to_json

    user_params = {
                    email: "whatever@example.com",
                    password: "password",
                    password_confirmation: "password"
                  }
    headers = { "CONTENT_TYPE" => "application/json",
                "ACCEPT" => "application/json"
              }

    post '/api/v0/users', headers: headers, params: user_params.to_json
    
    expect(response.status).to eq(422)

    user_info = JSON.parse(response.body, symbolize_names: true)
    expect(user_info[:errors].first[:status]).to eq("422")
    expect(user_info[:errors].first[:title]).to eq("User already exist")
  end

  it 'does not create a new user if password does not match' do
    user_params = {
                    email: "whatever@example.com",
                    password: "password",
                    password_confirmation: "badpassword"
                  }
    headers = { "CONTENT_TYPE" => "application/json",
                "ACCEPT" => "application/json"
              }

    post '/api/v0/users', headers: headers, params: user_params.to_json

    expect(response.status).to eq(400)

    user_info = JSON.parse(response.body, symbolize_names: true)
    expect(user_info[:errors].first[:status]).to eq("400")
    expect(user_info[:errors].first[:title]).to eq("Password must match")
  end

  it 'logs you in with the correct email and password' do
    User.create(email: "whatever@example.com", password: "password")

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
    expect(user_info[:attributes]).to have_key(:api_key)
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