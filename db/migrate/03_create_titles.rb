class CreateTitles < ActiveRecord::Migration
    create_table :titles do |t|
        t.string :name
    end
end