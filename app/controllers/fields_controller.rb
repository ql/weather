class FieldsController < JsonController
  respond_to :json
  before_action :authenticate

  def index
    respond Field::Index
  end

  def create
    op = run Field::Create, is_document: false do |op|
      render json: {status: :success, id: op.model.id}
      return
    end

    render json: {status: :fail, errors: op.errors}, status: 400
  end

  def show
    respond Field::Show
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: 404
  end

  def update
    run Field::Update
  end

  def delete
    run Field::Delete
  end

  def import
    #TODO TBD
  end

  def current_weather
    respond Field::CurrentWeather
  end

  def future_weather
    respond Field::FutureWeather
  end
end
