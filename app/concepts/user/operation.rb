class User < ActiveRecord::Base
  class SignUp < Trailblazer::Operation
    include Model
    
    contract do
      property :name
      property :email
      property :password, virtual: true

      validates :name, presence: true
      validates :email, presence: true
    end
  end

  class SignIn < Trailblazer::Operation
  end

  class SignOut < Trailblazer::Operation
    #TODO
  end

  class Update < Trailblazer::Operation
  end

  class Destroy < Trailblazer::Operation
    #TODO
  end
end
