class CreateJeus < ActiveRecord::Migration[6.1]
  def change
    create_table :jeus do |t|
      t.string :nomJeu
      t.string :lienJeu

      t.timestamps
    end
  end
end
