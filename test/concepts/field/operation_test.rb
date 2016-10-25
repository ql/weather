require 'test_helper'

class FieldOperationTest < MiniTest::Spec
  let (:field) { ::Field::Create.(field: {name: "TestField", boundary: geojson}).model }
  let (:geojson) { File.read(Rails.root.join('test', 'fixtures', 'files', 'field.geojson')) }

  describe "Create" do
    it "persists valid" do
      res, op = ::Field::Create.run(
        field: {
          name:       "TestField!",
          boundary:   geojson
        }
      )
      comment = op.model

      comment.persisted?.must_equal true
      comment.name.must_equal "TestField!"
      comment.area.must_equal 364044.06
      comment.center_lat.must_equal 55.55755538087183
      comment.center_lon.must_equal 37.40004197201306
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

      res, op = ::Field::Show.run(id: f.id)
      res.must_equal true
      op.model.must_equal f
    end

    it "uses correct representation" do
      json = ::Field::Show.present(id: field.id).to_json
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
