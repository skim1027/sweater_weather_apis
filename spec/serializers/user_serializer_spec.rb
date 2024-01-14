require 'rails_helper'

RSpec.describe UserSerializer do
  describe 'user serializer' do
    it 'creates data with id, type attributes with email and api_key' do
      user_params = {
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password"
      }
      user = User.create(user_params)
      user_serial = UserSerializer.new(user).serializable_hash

      expect(user_serial[:data]).to have_key(:id)
      expect(user_serial[:data]).to have_key(:type)
      expect(user_serial[:data]).to have_key(:attributes)
      expect(user_serial[:data][:attributes]).to have_key(:email)
      expect(user_serial[:data][:attributes][:email]).to eq("whatever@example.com")
      expect(user_serial[:data][:attributes]).to have_key(:api_key)
      expect(user_serial[:data][:attributes]).to_not have_key(:password)
    end
  end
end