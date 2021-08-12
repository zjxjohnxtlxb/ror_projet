class CreateEquipeSoftSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :equipe_soft_skills do |t|
      t.string :nomEquipe
      t.integer :niveauImportance, default: 0
      t.references :soft_skill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
