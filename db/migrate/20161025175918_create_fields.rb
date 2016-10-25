class CreateFields < ActiveRecord::Migration[5.0]
  def change
    create_table :fields do |t|
      t.integer   :user_id
      t.string    :name,      null: false
      t.text      :boundary,  null: false
      t.float     :area,      null: false
      t.float     :center_lat
      t.float     :center_lon
      t.timestamps
    end
  end
end
