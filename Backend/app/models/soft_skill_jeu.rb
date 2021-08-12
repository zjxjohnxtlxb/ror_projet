class SoftSkillJeu < ApplicationRecord
  belongs_to :soft_skill
  belongs_to :jeu
  validates :soft_skill_id, uniqueness: { scope: [:jeu_id]}
end
