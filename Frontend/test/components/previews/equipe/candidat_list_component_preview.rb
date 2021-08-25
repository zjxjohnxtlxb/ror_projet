class Equipe::CandidatListComponentPreview < ViewComponent::Preview
  def default
    render(Equipe::CandidatListComponent.new(candidats:{id:1, prenom:'yes', nom: 'yes'}))
  end

  def default_nil
    render(Equipe::CandidatListComponent.new)
  end
end
