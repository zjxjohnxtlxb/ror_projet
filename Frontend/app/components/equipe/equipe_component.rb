# frozen_string_literal: true

class Equipe::EquipeComponent < ViewComponent::Base
  with_collection_parameter :equipe

  def initialize(equipe: nil)
    @equipe = equipe
  end

  def id
    @equipe[:id]
  end

  def candidats
    @equipe[:candidats]
  end

  def recruteur
    @equipe[:recruteur]
  end

  def nomEquipe
    @equipe[:nomEquipe]
  end

  def niveauImportance
    @equipe[:niveauImportance]
  end

  def skill
    @equipe[:soft_skill_id]
  end
end
