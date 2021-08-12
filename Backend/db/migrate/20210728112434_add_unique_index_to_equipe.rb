class AddUniqueIndexToEquipe < ActiveRecord::Migration[6.1]
  def change
    add_index :equipes, [:recruteur_id, :candidat_id, :equipe_soft_skill_id], unique: true, name: 'equipe_index'
  end
end
