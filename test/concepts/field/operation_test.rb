require 'test_helper'

class FieldOperationTest < MiniTest::Spec
  let (:user) { ::User::SignUp.(user: {name: "Test User", email: "user@example.com", password: "qwerty"}).model }
  let (:field) { ::Field::Create.(field: {name: "TestField", boundary: geojson, user: user()}).model }
  let (:geojson) { File.read(Rails.root.join('test', 'fixtures', 'files', 'field.geojson')) }

  describe "Create" do
    it "persists valid" do
      field = field()

      field.persisted?.must_equal true
      field.name.must_equal "TestField"
      field.area.must_equal 364044.06
      field.center_lat.must_equal 55.55755538087183
      field.center_lon.must_equal 37.40004197201306
      field.user.must_equal user
    end

    it "do not persists invalid" do
      res, op = ::Field::Create.run(
        field: {
          name:       "TestField!"
        }
      )
      res.must_equal false
      op.errors.messages[:"boundary"].must_include "Invalid boundary: undefined method `size' for nil:NilClass"
    end
  end

  describe "Show" do
    it "retrieves field" do
      f = field

      res, op = ::Field::Show.run(id: f.id, user: f.user)
      res.must_equal true
      op.model.must_equal f
    end

    it "uses correct representation" do
      f = field
      json = ::Field::Show.present(id: f.id, user: f.user).to_json
      json.must_equal({"name"=>"TestField", "area"=>364044.06, "center_lat"=>55.55755538087183, "center_lon"=>37.40004197201306}.to_json)
    end
  end

  describe "Update" do
    it "updates field" do
      f = field

      res, op = ::Field::Update.run(
        id: f.id,
        field: {
          name: "NewName"
        }
      )
      res.must_equal true
      op.model.name.must_equal "NewName"
    end
  end

  describe "Delete" do
    it "deletes field" do
      f = field

      deleted = ::Field::Delete.(id: f.id).model
      deleted.destroyed?.must_equal true
    end
  end
end
