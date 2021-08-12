class AddUniqueIndexToSoftSkillJeu < ActiveRecord::Migration[6.1]
  def change
    add_index :soft_skill_jeus, [:soft_skill_id, :jeu_id], unique: true, name: 'soft_skill_jeu_index'
  end
end
