class SoftSkill < ApplicationRecord
    belongs_to :categorie_soft_skill
    has_many :soft_skill_jeus, dependent: :destroy
    has_many :equipe_soft_skills, dependent: :destroy
    has_many :scores, dependent: :destroy
end
