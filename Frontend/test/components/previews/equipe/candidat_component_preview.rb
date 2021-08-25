class Equipe::CandidatComponentPreview < ViewComponent::Preview
  def default
    render(Equipe::CandidatComponent.new(id:1,prenom:'foo', nom:'bar'))
  end
end
