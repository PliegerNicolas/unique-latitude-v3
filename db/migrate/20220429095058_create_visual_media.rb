class CreateVisualMedia < ActiveRecord::Migration[7.0]
  def change
    create_table :visual_media do |t|
      t.string :title, null: false
      t.string :author
      t.string :location
      t.date :date
      t.string :url, null: false
      t.text :description
      t.integer :media, null: false, default: 0 # Enum (Photo, Vidéo)
      t.integer :priority_index, null: false, default: 1
      t.belongs_to :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
