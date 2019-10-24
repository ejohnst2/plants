class CreatePlantTags < ActiveRecord::Migration[5.2]
  def change
    create_table :plant_tags do |t|
      t.references :plant, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
