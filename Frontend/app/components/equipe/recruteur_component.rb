# frozen_string_literal: true

class Equipe::RecruteurComponent < ViewComponent::Base
  def initialize(recruteur: nil)
    @recruteur = recruteur
  end

  def name
    "#{@recruteur[:prenom]} #{@recruteur[:nom]}"
  end

  def render?
    @recruteur.present?
  end
end
