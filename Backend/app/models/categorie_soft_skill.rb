class CategorieSoftSkill < ApplicationRecord
    has_many :soft_skills, dependent: :destroy
end
