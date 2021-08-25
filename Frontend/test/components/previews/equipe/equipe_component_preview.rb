class Equipe::EquipeComponentPreview < ViewComponent::Preview
  def default
    render(Equipe::EquipeComponent.new(id:1,candidat:{id:1, prenom:'yes', nom: 'yes'}, recruteur:{id:1, prenom:'no', nom: 'no'}))
  end
  def default_nil
    render(Equipe::EquipeComponent.new(id:1))
  end
end
