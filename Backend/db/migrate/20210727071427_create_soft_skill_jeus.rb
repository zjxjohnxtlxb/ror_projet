class CreateSoftSkillJeus < ActiveRecord::Migration[6.1]
  def change
    create_table :soft_skill_jeus do |t|
      t.references :soft_skill, null: false, foreign_key: true
      t.references :jeu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
