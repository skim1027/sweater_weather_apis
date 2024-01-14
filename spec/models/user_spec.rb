require 'rails_helper'

RSpec.describe User do
  describe 'validation' do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password)}
  end

  describe 'create user' do
    it 'creates user with api_key' do
      user = User.create(email: 'test@email.com', password: 'test', password_confirmation: 'test')
      expect(user.api_key).to be_present
    end
  end
end