class UsersController < JsonController
  respond_to :json

  def sign_up
    o = run User::SignUp do |op|
      render json: {status: :success}
    end

    render json: {errors: o.model.errors}
  end

  def sign_in
    run User::SignIn do |op|
      render json: {token:  op.model.token}
    end

    render json: {status: :fail}
  end

  def sign_out
    #TODO
  end

  def update
    #TODO
  end

  def delete
    #TODO
  end
end
