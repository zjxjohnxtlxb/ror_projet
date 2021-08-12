class EquipeSoftSkill < ApplicationRecord
  belongs_to :soft_skill
  has_many :equipes, dependent: :destroy
end
