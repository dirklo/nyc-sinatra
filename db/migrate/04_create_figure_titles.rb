class CreateFigureTitles < ActiveRecord::Migration
    create_table :figure_titles do |t|
        t.integer :title_id
        t.integer :figure_id
    end
end