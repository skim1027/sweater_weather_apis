require 'rails_helper'

describe 'user registration' do
  it 'creates a user with post info' do

    user_params = {
              email: "whatever@example.com",
              password: "password",
              password_confirmation: "password"
            }
    headers = {"CONTENT_TYPE" => "application/json"}
  
    post '/api/v0/users', headers: headers, params: JSON.generate(user: user_params)
    require 'pry'; binding.pry
    user_info = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response.status).to eq(201)

    expect(user_info).to have_key(:id)
    expect(user_info).to have_key(:type)
    expect(user_info).to have_key(:attributes)
    expect(user_info[:attributes]).to have_key(:email)
    expect(user_info[:attributes]).to have_key(:api_key)
    expect(user_info[:attributes]).to_not have_key(:password)
  end

  it 'does not create a new user if you are already registered'

  it 'does not create a new user if password does not match'
end