class FieldsController < JsonController
  respond_to :json
  before_action :authenticate

  def index
    respond Field::Index
  end

  def create
    new_params = {field: {name: params[:field][:name], boundary: params[:field][:boundary].to_unsafe_h}}
    run Field::Create, params: new_params, is_document: false do |op|
      render json: {id: op.model.id}
    end
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
