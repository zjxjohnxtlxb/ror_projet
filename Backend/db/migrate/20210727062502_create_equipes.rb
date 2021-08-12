class CreateEquipes < ActiveRecord::Migration[6.1]
  def change
    create_table :equipes do |t|
      t.references :recruteur, null: false, foreign_key: { to_table: :utilisateurs }
      t.references :candidat,  null: false, foreign_key: { to_table: :utilisateurs }
      t.references :equipe_soft_skill,  null: false, foreign_key: true

      t.timestamps
    end
  end
end
