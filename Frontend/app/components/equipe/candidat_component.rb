# frozen_string_literal: true

class Equipe::CandidatComponent < ViewComponent::Base
  with_collection_parameter :candidat
  def initialize(candidat: nil)
    @candidat = candidat
  end

  def name
    "#{@candidat[:prenom]} #{@candidat[:nom]}"
  end

  def render?
    @candidat.present?
  end
end
