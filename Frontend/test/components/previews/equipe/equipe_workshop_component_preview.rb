class Equipe::EquipeWorkshopComponentPreview < ViewComponent::Preview
  def default
    render(Equipe::EquipeWorkshopComponent.new)
  end
end
