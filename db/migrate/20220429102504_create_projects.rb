class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title, null: false, unique: true
      t.string :slug, unique: true
      t.string :subject
      t.integer :category, null: false # Enum (Documentaire, Institutionnel, Évènementiel)
      t.text :description
      t.string :location
      t.date :date
      t.integer :status, null: false, default: 0 # 0 = false, 1 = true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
