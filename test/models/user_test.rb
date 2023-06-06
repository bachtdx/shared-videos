require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "email should be unique" do
    existing_user = User.create(name: "John Doe", email: "johndoe@example.com", password: "password")
    new_user = User.new(name: "Jane Smith", email: "johndoe@example.com", password: "password")

    assert_not new_user.valid?
    assert_includes new_user.errors[:email], "has already been taken"
  end

  test "should not save user with invalid email format" do
    user = User.new(name: "John Doe", email: "invalid_email", password: "password")
    assert_not user.save
    assert_equal ["is invalid"], user.errors[:email]
  end

  test "should not save user without a email" do
    user = User.new(email: "", password: "password", name: "John Doe")
    assert_not user.save
    assert_equal ["can't be blank", "is invalid"], user.errors[:email]
  end

  test "should not save user without a name" do
    user = User.new(email: "john.doe@example.com", password: "password")
    assert_not user.save
    assert_equal ["can't be blank"], user.errors[:name]
  end

  test "should not save user without a password" do
    user = User.new(email: "john.doe@example.com", password: "", name: "John Doe")
    assert_not user.save
    assert_equal ["can't be blank"], user.errors[:password]
  end

  test "should save user with valid attributes" do
    user = User.new(name: "John Doe", email: "john.doe@example.com", password: "password")
    assert user.save
  end

  test "should not save user with invalid attributes" do
    user = User.new(name: "", email: "invalid_email", password: "short")
    assert_not user.save
    assert_equal ["Email is invalid", "Name can't be blank"], user.errors.full_messages
  end
end
