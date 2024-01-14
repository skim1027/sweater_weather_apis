class Api::V0::UsersController < ApplicationController
  def create
    require 'pry'; binding.pry
    user = User.new(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end