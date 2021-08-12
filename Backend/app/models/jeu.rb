class Jeu < ApplicationRecord
    has_many :soft_skill_jeus, dependent: :destroy
    has_many :scores, dependent: :destroy
end
