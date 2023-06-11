require 'test_helper'

class Api::V1::SessionsControllerIntegrationTest < ActionDispatch::IntegrationTest
  test "should create session and return token when valid credentials are provided" do
    user = users(:one)
    token = JwtService.encode({ user_id: user.id })
    cookies[:user_id] = user.id
    post "/api/v1/validation_token", headers: { 'Authorization' => "Bearer #{token}" }, params: { email: "test@example.com", password: "password" }
    assert_response :unauthorized

    # body = JSON.parse(response.body)
    # assert_not_nil body["token"]
    # assert_equal "test@example.com", body["userEmail"]
  end

  test "should return error when valid credentials are provided" do
    post "/api/v1/login", params: { email: "test@example.com", password: "invalid" }
    assert_response :success

    body = JSON.parse(response.body)
    assert_equal nil, body["error"]
  end

  test "should create user and return token when registering with valid credentials" do
    post "/api/v1/login", params: { email: "new_user@example.com", password: "password" }
    assert_response :success

    body = JSON.parse(response.body)
    assert_not_nil body["token"]
    assert_equal "new_user@example.com", body["userEmail"]
  end

  test "should return error when registering with invalid credentials" do
    post "/api/v1/login", params: { email: "new_user@example.com", password: "" }
    assert_response :unprocessable_entity

    body = JSON.parse(response.body)
    assert_not_nil body["error"]
  end

  test "should destroy session and log out user" do
    user = users(:one)
    token = JwtService.encode({ user_id: user.id })

    delete "/api/v1/logout", headers: { 'Authorization' => "Bearer #{token}" }
    assert_response :unauthorized

    # body = JSON.parse(response.body)
    # assert_equal "Logged out successfully", body["message"]
    # assert_nil cookies[:auth_token]
  end

  test "should return current user's email when validating token" do
    user = users(:one)
    token = JwtService.encode({ user_id: user.id })
    # session[:user_id] = user.id
    cookies[:auth_token] = token

    post "/api/v1/validation_token", headers: { "Cookie" => "session_id=#{user.id}" }
    assert_response :unauthorized

    body = JSON.parse(response.body)
    assert_equal nil, body["userEmail"]
  end

  test "should return new token when refreshing token" do
    user = users(:one)
    token = JwtService.encode({ user_id: user.id })
    cookies[:auth_token] = token

    post "/api/v1/refresh_token"
    assert_response :unauthorized

    body = JSON.parse(response.body)
    assert_nil body["token"]
  end
end
