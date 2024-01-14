class Api::V0::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      render json: UserSerializer.new(user), status: :ok
    else
      render json: { errors: [title: "Please put correct email and password", status: "400"]}, status: :bad_request
    end
  end
end