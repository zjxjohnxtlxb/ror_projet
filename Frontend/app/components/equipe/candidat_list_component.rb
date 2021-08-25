# frozen_string_literal: true

class Equipe::CandidatListComponent < ViewComponent::Base
  def initialize(candidats: nil)
    @candidats = candidats
  end

end
