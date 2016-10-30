require 'bcrypt'
class User < ActiveRecord::Base

  require "reform/form/validation/unique_validator.rb"
  class SignUp < Trailblazer::Operation
    include Model
    model User, :create
    
    contract do
      property :name
      property :email
      property :password
      property :token

      validates :name, presence: true
      validates :email, email: true, unique: true
    end

    def process(params)
      validate(params[:user]) do |contract|
        contract.password = digest(contract.password)
        contract.token = SecureRandom.hex(13)
        contract.sync
        contract.save # save User with email.
      end
    end

  private
    def digest(password)
      BCrypt::Password.create(password)
    end
  end

  class SignIn < Trailblazer::Operation
    contract do
      attr_reader :user

      property :email,    virtual: true
      property :password, virtual: true


      validates :email, presence: true
      validates :password, presence: true
      validate :password_ok?

    private

      def password_ok?
        @user = User.find_by(email: email)
        errors.add(:password, "Wrong password.") unless @user and (digest(@user.password) == password)
      end

      def digest(password)
        BCrypt::Password.new(password)
      end
    end

    def process(params)
      validate(params[:session]) do |contract|
        @model = contract.user
      end
    end
  end

  class SignOut < Trailblazer::Operation
    def process(params)
      user = params[:user]
      user.update_attribute(:token, SecureRandom.hex(13))
    end
  end

  class Update < Trailblazer::Operation
  end

  class Destroy < Trailblazer::Operation
    #TODO
  end
end
