class Parcour < ApplicationRecord
    alias_attribute :candidat_id, :utilisateur_id

    belongs_to :utilisateur
end
