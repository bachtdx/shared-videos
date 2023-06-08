require "test_helper"

class Api::V1::SessionsControllerTest < ActionController::TestCase
  test "should create session and return token" do
    user = users(:one)
    post :create, params: { email: user.email, password: "12345678" }
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_not_nil json_response["token"]
    assert_equal user.email, json_response["userEmail"]
    assert_equal user.name, json_response["userName"]
  end

  test "should return unauthorized for invalid credentials" do
    post :create, params: { email: "invalid@example.com", password: "password" }
    assert_response :unauthorized

    json_response = JSON.parse(response.body)
    assert_equal "Invalid email or password", json_response["error"]
  end

  test "should destroy session and return unauthorized" do
    delete :destroy
    assert_response :unauthorized

    json_response = JSON.parse(response.body)
    assert_equal "Authorization header missing or malformed", json_response["error"]
  end

  test "should destroy session and return success message" do
    user = users(:one)
    token = JwtService.encode(user_id: user.id)
    @request.session[:user_id] = user.id
    @request.headers["Authorization"] = "Bearer #{token}"
    delete :destroy
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal "Logged out successfully", json_response["message"]
  end

  test "should refresh token and return success message" do
    user = users(:one)
    token = JwtService.encode(user_id: user.id)
    @request.session[:user_id] = user.id
    @request.headers["Authorization"] = "Bearer #{token}"
    post :refresh_token
    assert_response :success

    json_response = JSON.parse(response.body)
    user_response = JwtService.decode(json_response["token"])
    assert_equal user.id, user_response["user_id"]
  end

  test "should refresh token and return unauthorizede" do
    post :refresh_token
    assert_response :unauthorized

    json_response = JSON.parse(response.body)
    assert_equal "Authorization header missing or malformed", json_response["error"]
  end
end
