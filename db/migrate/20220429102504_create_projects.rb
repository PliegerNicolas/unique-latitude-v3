class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.string :slug
      t.string :subject, null: false
      t.integer :category, null: false # Enum (Documentaire, Institutionnel, Évènementiel)
      t.text :description
      t.string :location
      t.date :date
      t.integer :published, null: false, default: 0 # 0 = false, 1 = true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
