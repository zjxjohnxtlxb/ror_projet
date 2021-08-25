class Equipe < ApplicationRecord
    belongs_to :recruteur, class_name: "Utilisateur", foreign_key: "recruteur_id"
    belongs_to :candidat, class_name: "Utilisateur", foreign_key: "candidat_id"
    belongs_to :equipe_soft_skill
    validates :recruteur_id, uniqueness: { scope: [:candidat_id, :equipe_soft_skill_id]}

    scope :get_candidats, -> (equipe_id) { where('equipe_soft_skill_id = ?', equipe_id)}
    scope :get_equipes, -> (utilisateur_id) { where('recruteur_id = ?', utilisateur_id).group(:equipe_soft_skill_id)}
end
