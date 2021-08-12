ActiveAdmin.register Parcour do
  belongs_to :utilisateur
  permit_params :metier, :secteur, :experience, :utilisateur_id
  
  controller do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

    def handle_not_found
      redirect_to  admin_utilisateur_parcours_path
    end
  end

  form do |f|
    f.inputs do
      f.input :metier
      f.input :secteur
      f.input :experience
    end
    f.actions
  end
end
