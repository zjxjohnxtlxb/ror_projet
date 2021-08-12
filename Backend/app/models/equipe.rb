class Equipe < ApplicationRecord
    belongs_to :recruteur, class_name: "Utilisateur", foreign_key: "recruteur_id"
    belongs_to :candidat, class_name: "Utilisateur", foreign_key: "candidat_id"
    belongs_to :equipe_soft_skill
    validates :recruteur_id, uniqueness: { scope: [:candidat_id, :equipe_soft_skill_id]}
end
