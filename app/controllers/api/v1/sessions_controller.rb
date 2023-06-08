class Api::V1::SessionsController < ApplicationController
  before_action :authenticate_request, except: [:create]

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = JwtService.encode({ user_id: user.id })
      session[:user_id] = user.id
      render json: { token: token, userEmail: user.email, userName: user.name }
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { message: "Logged out successfully" }
  end

  def refresh_token
    token = JwtService.encode({ user_id: session[:user_id] })
    render json: { token: token }
  end
end
