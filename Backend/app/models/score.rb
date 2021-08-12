class Score < ApplicationRecord
  belongs_to :utilisateur
  belongs_to :soft_skill_jeu
end
