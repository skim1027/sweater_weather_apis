class Api::V0::UsersController < ApplicationController
  def create
    if params[:password] == params[:password_confirmation]
      existing_user = User.find_by(email: params[:email])
      new_user = User.new(
          email: params[:email],
          password: params[:password]
        )
      if existing_user
        render json: { error: [title: "User already exist"] }, status: :unprocessable_entity
      elsif new_user.save
        render json: UserSerializer.new(new_user), status: :created
      end
    else
      render json: { error: [title: "Password must match"] }, status: :bad_request
    end
  end
end