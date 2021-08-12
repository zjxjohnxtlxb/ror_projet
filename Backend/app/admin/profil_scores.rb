ActiveAdmin.register ProfilScore do
  permit_params :identity, :social, :logic, :pitch, :utilisateur_id
  belongs_to :utilisateur, singleton: true

  controller do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

    def handle_not_found
      redirect_to admin_utilisateur_path
    end

  end
end
