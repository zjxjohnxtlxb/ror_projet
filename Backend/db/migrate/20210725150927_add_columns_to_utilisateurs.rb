class AddColumnsToUtilisateurs < ActiveRecord::Migration[6.1]
  def change
    add_column :utilisateurs, :niveauExperience, :string
    add_column :utilisateurs, :passion1, :string
    add_column :utilisateurs, :passion2, :string
    add_column :utilisateurs, :passion3, :string
    add_column :utilisateurs, :linkFacebook, :string
    add_column :utilisateurs, :linkTwitter, :string
    add_column :utilisateurs, :linkLinkedin, :string
    add_column :utilisateurs, :linkViadeo, :string
  end
end
