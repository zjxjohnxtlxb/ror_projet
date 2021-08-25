# frozen_string_literal: true

class Equipe::EquipeWorkshopComponent < ViewComponent::Base
  def initialize(equipes:nil, candidats:nil, recruteur:nil)
    @equipes = equipes
    @candidats = candidats
    @recruteur = recruteur
  end
end
