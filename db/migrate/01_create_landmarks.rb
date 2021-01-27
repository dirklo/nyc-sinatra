class CreateLandmarks < ActiveRecord::Migration
  create_table :landmarks do |t|
    t.string :name
    t.integer :year_completed
    t.integer :figure_id
  end
end
