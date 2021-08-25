class Equipe::RecruteurComponentPreview < ViewComponent::Preview
  def default
    render(Equipe::RecruteurComponent.new(id:1,prenom:'foo', nom:'bar'))
  end
end
