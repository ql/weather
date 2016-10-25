class FieldsController < JsonController
  def index
  end

  def create
    run Comment::Create
  end

  def show
    run Comment::Show
  end

  def update
    run Comment::Update
  end

  def delete
    run Comment::Delete
  end

  def import
    #TODO TBD
  end
end
