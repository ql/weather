require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  describe "sign_up" do
    it "should work" do
      post "sign_up", params: {user: {name: "Test User", email: "valid2@example.com", password: "qwerty"}}, headers: { "Content-Type" => "application/json" }
      response.status.must_equal 200
      json = JSON.parse(response.body)
      json["status"].must_equal "success"
    end
  end

  describe "sign_in" do
    it "should work with valid creds" do
      user = ::User::SignUp.(user: { name:     "Test User", email:    "valid3@example.com", password: "qwerty"} ).model

      post "sign_in", params: {session: {email: "valid3@example.com", password: "qwerty"}}, headers: { "Content-Type" => "application/json" }
      response.status.must_equal 200
      json = JSON.parse(response.body)
      json["status"].must_equal "success"
      json["token"].wont_be_nil
    end

    it "should work with invalid creds" do
      user = ::User::SignUp.(user: { name:     "Test User", email:    "valid3@example.com", password: "qwerty"} ).model

      post "sign_in", params: {session: {email: "valid2@example.com", password: "qwerty"}}, headers: { "Content-Type" => "application/json" }
      response.status.must_equal 401
      json = JSON.parse(response.body)
      json["status"].must_equal "fail"
      json["token"].must_be_nil
    end
  end

  describe "sign_out" do
    it "should not work when not logged in" do
      post "sign_out", params: {}, headers: { "Content-Type" => "application/json" }
      response.status.must_equal 401
    end

    it "should work when logged in" do
      user = ::User::SignUp.(user: { name:     "Test User", email:    "valid3@example.com", password: "qwerty"} ).model
      token = user.token
      request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{token}\""
      post "sign_out", {params: {}}
      response.status.must_equal 200
      user.reload.token.wont_equal token
    end
  end
end
