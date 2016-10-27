class UsersController < JsonController
  respond_to :json

  def sign_up
    op = run User::SignUp do |o|
      render({json: {status: :success, id: o.model.id}})
      return
    end

    render json: {errors: op.errors}
  end

  def sign_in
    op = run User::SignIn do |op|
      render json: {token:  op.model.token}
      return
    end

    render json: {status: :fail, errors: op.errors}
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
