class AddUtilisateurToParcour < ActiveRecord::Migration[6.1]
  def change
    add_reference :parcours, :utilisateur, null: false, foreign_key: true
  end
end
