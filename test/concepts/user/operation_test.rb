require 'test_helper'

class UserOperationTest < MiniTest::Spec
  describe "SignUp" do
    it "creates user when params are valid" do
      res, op = ::User::SignUp.run(
        user: {
          name:     "Test User",
          email:    "valid@example.com",
          password: "qwerty"
        }
      )

      user = op.model

      user.persisted?.must_equal true
      user.name.must_equal "Test User"
      user.password.wont_be_nil
      user.password.wont_equal "qwerty"
    end

    it "return error if params are not valid" do
      res, op = ::User::SignUp.run(
        user: {
          email:    "invalid@example",
          password: "qwerty"
        }
      )

      res.must_equal false
      op.errors.messages[:"email"].must_include "is invalid"
      op.errors.messages[:"name"].must_include "can't be blank"
    end
  end

  describe "SignIn" do
    before(:each) do
      ::User::SignUp.run(
        user: {
          name:     "Test User",
          email:    "valid@example.com",
          password: "qwerty"
        }
      )
    end

    it "returns user token if credentials are valid" do
      res, _ = ::User::SignIn.run(
        {session: {email:"valid@example.com", password:"qwerty"}}
      )

      res.must_equal true
    end

    it "returns error if credentials are not valid" do
      res, _ = ::User::SignIn.run(
        {session: {email:"valid@example.com", password:"INVALID"}}
      )

      res.must_equal false
    end
  end
end
