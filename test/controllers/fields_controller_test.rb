require 'test_helper'

class FieldsControllerTest < ActionController::TestCase
  let (:user) { ::User::SignUp.(user: {name: "Test User", email: "user@example.com", password: "qwerty"}).model }
  let (:field) { ::Field::Create.(field: {name: "TestField", boundary: geojson, user: user()}).model }
  let (:geojson) { File.read(Rails.root.join('test', 'fixtures', 'files', 'field.geojson')) }

  it "should create field" do
    user1 = ::User::SignUp.(user: {name: "User 1", email: "user1@example.com", password: "qwerty"}).model 
    request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{user1.token}\""

    process :create, method: :post, params: {field: {name: "TestField", boundary: geojson}}
    response.status.must_equal 204
  end

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

  it "should index only users fields" do
    user1 = ::User::SignUp.(user: {name: "User 1", email: "user1@example.com", password: "qwerty"}).model 
    field1 = ::Field::Create.(field: {name: "user1 field ", boundary: geojson, user: user1}).model 

    user2 = ::User::SignUp.(user: {name: "User 2", email: "user2@example.com", password: "qwerty"}).model 
    field2 = ::Field::Create.(field: {name: "user2 field", boundary: geojson, user: user2}).model 

    request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{user1.token}\""
    get :index, format: :json
    response.status.must_equal 200
    response.body.must_include 'user1 field'
    response.body.wont_include 'user2 field'

    request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{user2.token}\""
    get :index, format: :json
    response.status.must_equal 200
    response.body.must_include 'user2 field'
    response.body.wont_include 'user1 field'
  end

  it "should return current weather" do
    user1 = ::User::SignUp.(user: {name: "User 1", email: "user1@example.com", password: "qwerty"}).model 
    field1 = ::Field::Create.(field: {name: "user1 field ", boundary: geojson, user: user1}).model 
    request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{user1.token}\""

    get :current_weather, params: {id: field1.id}, format: :json

    response.body.must_include 'temperature'
    response.status.must_equal 200
  end

  it "should return weather prediction" do
    user1 = ::User::SignUp.(user: {name: "User 1", email: "user1@example.com", password: "qwerty"}).model 
    field1 = ::Field::Create.(field: {name: "user1 field ", boundary: geojson, user: user1}).model 
    request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{user1.token}\""

    get :future_weather, params: {id: field1.id}, format: :json

    response.body.must_include 'temperature'
    response.status.must_equal 200
  end
end
