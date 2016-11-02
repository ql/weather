class UsersController < JsonController
  respond_to :json

  before_action :authenticate, only: [:sign_out]

  def sign_up
    op = run User::SignUp do |o|
      render({json: {status: :success, id: o.model.id}})
      return
    end

    render json: {errors: op.errors}
  end

  def sign_in
    op = run User::SignIn do |op|
      render json: {status: :success, token:  op.model.token}
      return
    end

    render json: {status: :fail, errors: op.errors}, status: 401
  end

  def sign_out
    run User::SignOut, params: {user: current_user} do |op|
      render json: {status: :success}
      return
    end
  end

  def update
    #TODO
  end

  def delete
    #TODO
  end

  def current_weather
    #TODO
  end

  def weather_prediction
    #TODO
  end
end
