class CreateProfilScores < ActiveRecord::Migration[6.1]
  def change
    create_table :profil_scores do |t|
      t.string :identity
      t.string :social
      t.string :logic
      t.string :pitch
      t.references :utilisateur, null: false, foreign_key: true

      t.timestamps
    end
  end
end
