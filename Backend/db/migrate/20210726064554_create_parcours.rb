class CreateParcours < ActiveRecord::Migration[6.1]
  def change
    create_table :parcours do |t|
      t.string :metier
      t.string :secteur 
      t.string :experience
      
      t.timestamps
    end
  end
end
