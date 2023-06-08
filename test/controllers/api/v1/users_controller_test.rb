require "test_helper"

class Api::V1::UsersControllerTest < ActionController::TestCase
  test "should create a new user" do
    post :create, params: {
               user: {
                 name: "John Doe",
                 email: "john.doe@example.com",
                 password: "password",
               },
             }

    assert_response :created
    assert_equal "User created successfully", JSON.parse(response.body)["message"]
  end

  test "should return errors when creating an invalid user" do
    post :create, params: {
               user: {
                 name: "",
                 email: "",
                 password: "",
               },
             }

    assert_response :unprocessable_entity
    assert_includes JSON.parse(response.body)["error"], "Name can't be blank"
    assert_includes JSON.parse(response.body)["error"], "Email can't be blank"
    assert_includes JSON.parse(response.body)["error"], "Password can't be blank"
  end

  test "should return errors when creating email invalid" do
    post :create, params: {
               user: {
                 name: "John Doe",
                 email: "john.doe@@example.com",
                 password: "password",
               },
             }

    assert_response :unprocessable_entity
    assert_includes JSON.parse(response.body)["error"], "Email is invalid"
  end
end
