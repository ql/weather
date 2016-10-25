class FieldsController < JsonController
  respond_to :json

  def index
  end

  def create
    new_params = {field: {name: params[:field][:name], boundary: params[:field][:boundary].to_unsafe_h}}
    respond Field::Create, params: new_params, is_document: false
  end

  def show
    respond Field::Show
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
end
