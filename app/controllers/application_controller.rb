class ApplicationController < ActionController::API
  before_action :authenticate_request

  def current_user
    @current_user = User.find(session[:user_id])
  end
  
  private

  def authenticate_request
    header = request.headers["Authorization"]
    if header && header.starts_with?("Bearer ")
      token = header.slice(7..-1)
      begin
        decoded_token = JwtService.decode(token)
        render json: { error: "Invalid token" }, status: :unauthorized if session[:user_id] != decoded_token[:user_id]
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound
        render json: { error: "Invalid token" }, status: :unauthorized
      end
    else
      render json: { error: "Authorization header missing or malformed" }, status: :unauthorized
    end
  end
end
