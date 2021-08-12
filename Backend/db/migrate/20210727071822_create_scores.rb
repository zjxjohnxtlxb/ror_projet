class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.integer :resultat
      t.date :dateScores
      t.references :utilisateur, null: false, foreign_key: true
      t.references :soft_skill_jeu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
