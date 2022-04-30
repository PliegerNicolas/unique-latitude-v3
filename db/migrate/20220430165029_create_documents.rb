class CreateMedia < ActiveRecord::Migration[7.0]
  def change
    create_table :media do |t|
      t.string :title, null: false
      t.text :description
      t.string :author
      t.string :location
      t.date :date
      t.integer :priority_index, default: 1, null: false
      t.belongs_to :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
