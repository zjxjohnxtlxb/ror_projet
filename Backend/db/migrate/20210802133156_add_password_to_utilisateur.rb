class AddPasswordToUtilisateur < ActiveRecord::Migration[6.1]
  def change
    add_column :utilisateurs, :password_digest, :string
    add_index :utilisateurs, [:email], unique: true
  end
end
