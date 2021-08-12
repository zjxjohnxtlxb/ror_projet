class Utilisateur < ApplicationRecord
    has_many :parcours, dependent: :destroy
    has_one :profil_score, dependent: :destroy
    has_many :recruteur_equipes, class_name: "Equipe", foreign_key: "recruteur_id"
    has_many :candidat_equipes, class_name: "Equipe", foreign_key:"candidat_id"
    validates :email, uniqueness: true, presence: true

    has_secure_password
    
    scope :is_recruteur, -> { where(roleNo:0) }
    scope :is_candidat, -> { where(roleNo:1) }
end
