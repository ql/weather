require 'test_helper'

class FieldsControllerTest < ActionController::TestCase
  let (:user) { ::User::SignUp.(user: {name: "Test User", email: "user@example.com", password: "qwerty"}).model }
  let (:field) { ::Field::Create.(field: {name: "TestField", boundary: geojson, user: user()}).model }
  let (:geojson) { File.read(Rails.root.join('test', 'fixtures', 'files', 'field.geojson')) }

  it "should not show other user's field" do
    user1 = ::User::SignUp.(user: {name: "User 1", email: "user1@example.com", password: "qwerty"}).model 
    user2 = ::User::SignUp.(user: {name: "User 2", email: "user2@example.com", password: "qwerty"}).model 
    field = ::Field::Create.(field: {name: "TestField", boundary: geojson, user: user1}).model 
    
    request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{user1.token}\""
    get :show, params: {id: field.id}, format: :json
    response.status.must_equal 200

    request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{user2.token}\""
    get :show, params: {id: field.id}, format: :json
    response.status.must_equal 404
  end
end
