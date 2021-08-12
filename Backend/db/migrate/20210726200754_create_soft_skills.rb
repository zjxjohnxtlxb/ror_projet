class CreateSoftSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :soft_skills do |t|
      t.string :nomSoftSkill
      t.references :categorie_soft_skill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
