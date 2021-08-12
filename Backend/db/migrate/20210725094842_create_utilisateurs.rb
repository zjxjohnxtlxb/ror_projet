class CreateUtilisateurs < ActiveRecord::Migration[6.1]
  def change
    create_table :utilisateurs do |t|
      t.string :nom
      t.string :prenom
      t.string :email
      t.date :dateDeNaissance
      t.string :telephone
      t.integer :roleNo

      t.timestamps
    end
  end
end
