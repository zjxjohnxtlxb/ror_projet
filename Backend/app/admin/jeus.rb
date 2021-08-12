ActiveAdmin.register Jeu do
  permit_params :nomJeu, :lienJeu
  menu parent: "Param Jeu et Skills", priority: 2
  
  controller do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

    def handle_not_found
      redirect_to admin_jeus_path
    end
  end

end
