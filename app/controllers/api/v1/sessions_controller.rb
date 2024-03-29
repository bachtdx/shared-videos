class Api::V1::SessionsController < ApplicationController
  before_action :authenticate_request, except: [:create]

  def create
    user = User.find_by(email: params[:email])
    if user
      if user.authenticate(params[:password])
        token = JwtService.encode({ user_id: user.id })
        session[:user_id] = user.id
        user.update_is_logined(true)
        render json: { token: token, userEmail: user.email }
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    else
      user = User.new({ email: params[:email], password: params[:password] })
      if user.save
        token = JwtService.encode({ user_id: user.id })
        session[:user_id] = user.id
        user.update_is_logined(true)
        render json: { token: token, userEmail: user.email }
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def destroy
    current_user.update_is_logined(false)
    session[:user_id] = nil
    render json: { message: 'Logged out successfully' }
  end

  def validation_token
    render json: { userEmail: current_user.email }
  end

  def refresh_token
    token = JwtService.encode({ user_id: session[:user_id] })
    render json: { token: token }
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
