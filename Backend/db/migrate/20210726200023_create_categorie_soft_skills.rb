class CreateCategorieSoftSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :categorie_soft_skills do |t|
      t.string :nomCategorie

      t.timestamps
    end
  end
end
