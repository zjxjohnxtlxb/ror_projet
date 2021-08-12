class ProfilScore < ApplicationRecord
  belongs_to :utilisateur

  alias_attribute :candidat_id, :utilisateur_id
end
